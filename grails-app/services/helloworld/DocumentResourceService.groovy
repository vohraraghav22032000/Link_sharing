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
        if(params.docpath.getSize()/1024 > 26214400){
            return false
        }

        DocumentResource docres = new DocumentResource();
        Topic topic = Topic.findById(params.docTopic)
        docres.topic = topic

        try{
            def multipartFile = params.docpath
            def fileExtension = multipartFile.getOriginalFilename().tokenize('.')[-1]

            def bytes = multipartFile.getBytes()
            int num = generateRandomNumber()
            def url = "grails-app/assets/documents/${num}.${fileExtension}"
            def newFile = new File("${url}")

            newFile.createNewFile()
            newFile.append(bytes)

            docres.filePath = "/assets/${num}.${fileExtension}"
        } catch(FileUploadBase.FileSizeLimitExceededException e){
            docres.filePath = params.docpath
            return false
        }
        catch (Exception e){
            println e
        }

        docres.createdBy = currUser
        docres.description = params.docdes
        def allSubUser = topic.subscriptions*.user
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
        }
        catch (Exception e){
            println e
        }
        return true
    }

    def deletePost(){

    }
}
