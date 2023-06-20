package helloworld

class ResourceRatingController {

    def index() {
        if(session.username == null){
            redirect(url :"/")
            return
        }
    }

    def rateResource(){
        def resource = Resource.get(Integer.parseInt(params.resourceId))
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
        def resource = Resource.findById(params.resourceId)
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

    def updateDocumentResource(){
        def resource = Resource.findById(params.resourceId)
        if(resource){
            resource.filePath = params.docpath
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
        def resource = Resource.findById(params.resourceId)
        if(resource){
            println "resource found to delete in delete resource" + resource
        }
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
