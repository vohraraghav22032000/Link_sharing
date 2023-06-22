package helloworld

import Enum.Visibility

class TopicController {

    def topicService

    def index() {
        if(session.username==null){
            redirect(url :"/authentication")
            return
        }
    }

    def saveTopic(){
        User user = User.findByUsername(session.username);
        List topicCreatedByUser = Topic.createCriteria().list(){eq("createdBy",user)}
        List topicCreatedByUserName = topicCreatedByUser.collect { topic -> topic.name}

        if(topicCreatedByUserName.contains(params.topicName)){
            flash.errorMessage= "This topic has already been created By You"
            redirect(url : "/dashboard", model :['msg' : flash.errorMessage ])
        }
        else{
            boolean flag = topicService.saveTopicUsingCredentials(params , user)

            if(flag){
                flash.successMessage = "Topic created Successfully"
                redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
            }
            else{
                flash.errorMessage = "Topic name should not be greater than 128 characters"
                redirect(url : "/dashboard", model :['msg' : flash.errorMessage ])
            }
        }
    }

    def updateVisibility(){
        Topic topic = Topic.get(params.topicId)
        if (topic) {
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
        Topic topic = Topic.get(params.topicId)
        if (topic) {
            topic.delete(flush: true)
            render(status: 200, text: 'Topic deleted')
        } else {
            println "Topic Not found"
            render(status: 404, text: 'Topic not found')
        }
    }

    def updateTopicName(){
        Topic topic = Topic.get(params.topicId)
        if (params.newTopicName.length()<128 && params.newTopicName.trim() != '') {
            topic.name = params.newTopicName
            topic.save(flush: true , failOnError:true)
            render(status: 200, text: 'Topic name updated Successfully')
        }
        else{
                render(status: 404, text: 'Topic Name not updated successfully')
        }
    }


    def sendInvitation(){
        boolean flag = topicService.sendInvite(params)
        if(flag){
            flash.successMessage = "invitation sent successfully"
            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
        else {
            flash.errorMessage = "Please enter valid email"
            redirect(url : "/dashboard", model :['msg' : flash.errorMessage ])
        }
    }
}
