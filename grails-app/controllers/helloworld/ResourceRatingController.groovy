package helloworld

import org.apache.tomcat.util.http.fileupload.FileUploadBase

import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.commons.CommonsMultipartResolver
import org.springframework.web.multipart.MultipartException

class ResourceRatingController {

    def index() {
        if(session.username == null){
            redirect(url :"/")
            return
        }
    }

    def rateResource(){
        Resource resource = Resource.get(Integer.parseInt(params.resourceId))
        Integer currScore = Integer.parseInt(params.score)
        User user = User.findByUsername(session.username)
        ResourceRating resourceRating1 = ResourceRating.findByUserAndResource(user,resource);
        if(resourceRating1){
            resourceRating1.score = currScore
            resourceRating1.save(flush:true , failOnError : true)
            render(status: 200, text: 'Your rating is saved successfully')
        }
        else{
            ResourceRating resourceRating = new ResourceRating()
            resourceRating.user = user
            resourceRating.resource = resource
            resourceRating.score = currScore
            resourceRating.validate()
            resourceRating.save(flush:true , failOnError : true)
            render(status: 200, text: 'Your rating is saved successfully')
        }
    }

    def updateLinkResource(){
        Resource resource = Resource.findById(params.resourceId)
        if(resource){
            resource.url = params.doclink
            resource.description = params.docdes

            resource.save(flush:true , failOnError : true)
            flash.successMessage = "Link resources are updated successfully"
            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
        else{
            flash.errorMessage= "Link resources are not updated successfully"
            redirect(url : "/dashboard", model :['msg' : flash.errorMessage ])
        }
    }
    int generateRandomNumber(){
        return Math.round(Math.random() * 1e6)
    }

    def updateDocumentResource(){
        Resource resource = Resource.findById(params.resourceId)
        if(resource){
//            resource.filePath = params.docpath
            def multipartFile = params.docpath
            def fileExtension = multipartFile.getOriginalFilename().tokenize('.')[-1]

            def bytes = multipartFile.getBytes()
            int num = generateRandomNumber()
            def url = "grails-app/assets/documents/${num}.${fileExtension}"
            def newFile = new File("${url}")

            newFile.createNewFile()
            newFile.append(bytes)

            resource.filePath = "/assets/${num}.${fileExtension}"
            resource.description = params.docdes
            resource.save(flush:true , failOnError : true)
            flash.successMessage = "Document resources are updated successfully"
            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
        else{
            flash.errorMessage = "Document resources are not updates successfully"
            redirect(url : "/dashboard", model :['msg' : flash.errorMessage ])
        }
    }

    def deleteResource(){
        Resource resource = Resource.findById(params.resourceId)
        if(resource){
            resource.delete(flush:true , failOnError : true)
            flash.successMessage = "Resource deleted successfully"
            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
        else{
            flash.errorMessage = "Resource are not deleted successfully"
            redirect(url : "/dashboard", model :['msg' : flash.errorMessage])
        }
    }
}
