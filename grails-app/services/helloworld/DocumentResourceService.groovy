package helloworld

import org.apache.tomcat.util.http.fileupload.FileUploadBase

//import org.springframework.web.multipart.MultipartFile
//import org.springframework.web.multipart.MultipartFile
//import org.springframework.web.multipart.commons.CommonsMultipartResolver
import org.springframework.web.multipart.MultipartException
//import org.apache.tomcat.util.http.fileupload.FileUploadBase$SizeLimitExceededException

class DocumentResourceService {

    int generateRandomNumber(){
        return Math.round(Math.random() * 1e6)
    }

    def saveDocumentUsingCredentials(def params , User currUser){
        if(params.docdes.length()>=128){
            return false
        }
        println ">>>>>>>>>>???????????>>>>>>>>>>>>>>>>>>>>>>>>>>>."
//        println params.docpath.getSize()
        if(params.docpath.getSize()/1024 > 26214400){
            println "size of file is greater"
            return false
        }

        DocumentResource docres = new DocumentResource();
//        docres.filePath = params.docpath

        Topic topic = Topic.findById(params.docTopic)
        docres.topic = topic

        try{
            def multipartFile = params.docpath
            println "multipartFile" + multipartFile
            def fileExtension = multipartFile.getOriginalFilename().tokenize('.')[-1]

            def bytes = multipartFile.getBytes()

            println "bytes" +bytes
//            def url = "grails-app/assets/${params.docpath}.${fileExtension}"
            int num = generateRandomNumber()
            def url = "grails-app/assets/documents/${num}.${fileExtension}"
            def newFile = new File("${url}")
            println url
            println "newFile" + newFile

            newFile.createNewFile()
            newFile.append(bytes)

            docres.filePath = "/assets/${num}.${fileExtension}"
        } catch(FileUploadBase.FileSizeLimitExceededException e){
            println ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
            println e
            docres.filePath = params.docpath
            return false
//            u.photo = "grails-app/assets/images/defaultImage.png"
        }
        catch (Exception e){
            println e
        }

        docres.createdBy = currUser
        docres.description = params.docdes
        def allSubUser = topic.subscriptions*.user
//        println "size of file is "  + params.docpath.getSize()
        println "----------------->in document resource--------->" + allSubUser

        docres.validate()
        docres.save(flush : true , failOnError : true)
        try{
            allSubUser.each{it->
                ReadingItem readingItem = new ReadingItem()
                readingItem.user = it
                readingItem.resource = docres
                readingItem.isRead = false
                readingItem.validate()
                "reading item for all user subscribed successfully"
                readingItem.save(flush:true , failOnError : true)
            }
            println "Reading item is saved successfully"
        }
        catch (Exception e){
            println "reading Item not saved" + e
        }
        return true
    }

    def deletePost(){

    }
}
