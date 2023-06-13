package helloworld

import Enum.Visibility

class TopicController {

    def topicService

    def index() {
        if(session.username==null){
            redirect(url :"/index")
            return
        }
        def myList = topicService.getTopRecentPosts()
        //def recentList = topicService.getAllPosts()
        render recentList
        //[posts: myList]
       // render(template: '/layouts/recentShares' , model : [abc: "", posts : [1, 2]])
    }

    def saveTopic(){
        User user = User.findByUsername(session.username);
        def topicCreatedByUser = Topic.createCriteria().list(){eq("createdBy",user)}
        def topicCreatedByUserName = topicCreatedByUser.collect { topic -> topic.name}

        if(topicCreatedByUserName.contains(params.topicName)){
            flash.successMessage = "This topic has already been created By You"
            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
        else{
            boolean flag = topicService.saveTopicUsingCredentials(params , user)

            if(flag){
                flash.successMessage = "Topic created Successfully"
                redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
            }
            else{
                flash.successMessage = "Topic name should not be greater than 128 characters"
                redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
            }
        }
    }

    def getAllPosts(){
        def result = topicService.getAllPosts()
        render result
    }

    def updateVisibility(){
        println "params in delete subscription" + params
        def topic = Topic.get(params.topicId)
        if (topic) {
//            println "topic found" + topic

            if(params.selectedOption=='PRIVATE'){
                topic.visibility = Visibility.PRIVATE
            }
            else{
                topic.visibility = Visibility.PUBLIC
            }

            topic.save(flush : true,failOnError : true)
            render(status: 200, text: 'visibility updated')
        } else {
            render(status: 404, text: 'visibility not updated')
        }
    }

    def deleteTopic(){

        print "delete topic" + params
        def topic = Topic.get(params.topicId)
        if (topic) {
            topic.delete(flush: true)
            println "Successfully deleted the topic"
//            flash.successMessage = "Topic deleted Successfully"
//            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
            render(status: 200, text: 'Topic deleted')
        } else {
            println "Topic Not found"
            render(status: 404, text: 'Topic not found')
        }
    }

    def updateTopicName(){
//        println "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%params in update topic name-------->" + params
        print "delete topic" + params

        def topic = Topic.get(params.topicId)
        if (params.newTopicName.length()<128) {
            println "topic found successfully"
            topic.name = params.newTopicName
            topic.save(flush: true , failOnError:true)
//            flash.successMessage = "Topic name updated Successfully"
//            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
//            render ([message: "Thanks for your subscription"] )
            render(status: 200, text: 'Topic name updated Successfully')
        }
        else{
                render(status: 404, text: 'Topic Name not updated successfully')
//            println "topic not found"
//            flash.successMessage = "Topic name not updated Successfully"
//            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
    }


    def sendInvitation(){
        println "params in send invitation" + params
        def flag = topicService.sendInvite(params)
        if(flag){
            flash.successMessage = "invitation sent successfully"
            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
        else {
            flash.successMessage = "Please enter valid email"
            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
    }

}
