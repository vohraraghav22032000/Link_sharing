package helloworld

class ResourceRatingController {

    def index() { }

    def rateResource(){
        println "params in rateResource" + params
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
//             render(status: 200, [message: "Thanks for your subscribtion"] as JSON)
        }
    }

    def updateLinkResource(){
//        println "params in update link resource" + params
//        def topic = Topic.get(Integer.parseInt(params.topicId))
//        def resource = Resource.get(Integer.parseInt(params.resourceId))
        def resource = Resource.findById(params.resourceId)
//        def topic = Topic.findById(params.topicId)
        if(resource){
            resource.url = params.doclink
            resource.description = params.docdes

            resource.save(flush:true , failOnError : true)
            println "resource updated successfully"
            flash.successMessage = "Link resources are updated successfully"
            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
        else{
            println "resource not found"
            flash.successMessage = "Link resources are not updates successfully"
            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
    }

    def updateDocumentResource(){
//        println "params in update link resource" + params
//        def topic = Topic.get(Integer.parseInt(params.topicId))
//        def resource = Resource.get(Integer.parseInt(params.resourceId))
        def resource = Resource.findById(params.resourceId)
//        def topic = Topic.findById(params.topicId)
        if(resource){
            resource.filePath = params.docpath
            resource.description = params.docdes

            resource.save(flush:true , failOnError : true)
            println "resource updated successfully"
            flash.successMessage = "Document resources are updated successfully"
            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
        else{
            println "resource not found"
            flash.successMessage = "Document resources are not updates successfully"
            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
    }

    def deleteResource(){
        def resource = Resource.findById(params.resourceId)
        if(resource){
            println "resource found to delete in delete resource" + resource
        }
        if(resource){
            resource.delete(flush:true , failOnError : true)
//            println "resource updated successfully"
            flash.successMessage = "Resource deleted successfully"
            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
        else{
//            println "resource not found"
            flash.successMessage = "Resource are not deleted successfully"
            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
    }
}
