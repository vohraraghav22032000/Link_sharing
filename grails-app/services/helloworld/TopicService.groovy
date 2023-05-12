package helloworld

import Enum.Seriousness
import Enum.Visibility
import grails.converters.JSON

class TopicService {

    def saveTopicUsingCredentials(def params , User currUser) {
        Topic topic = new Topic();
        topic.name = params.topicName;
        //topic.visibility = Visibility.PUBLIC
        topic.createdBy = currUser

        if(params.visibility == 'public'){
            topic.visibility = Visibility.PUBLIC
        }
        else{
            topic.visibility = Visibility.PRIVATE
        }

//        new Topic(name: params.topicName, createdBy: User.findByUsername('ankit_mishra'), visibility: Visibility.PUBLIC).save(flush: true, failOnError: true)
//        new Topic(name: params.topicName, createdBy: User.findByUsername('farhan_ali'), visibility: Visibility.PRIVATE).save(flush: true, failOnError: true)

        if(topic.validate()){
            topic.save(flush : true , failOnError : true)
            subscribedToTopic(topic,currUser)
            return true
        }
        else{
            if(topic.hasErrors()){
                println topic.errors
            }
            return false
        }
    }

    def subscribedToTopic(Topic topic,User currUser){
        Subscription subs = new Subscription();
        subs.topic = topic;
        subs.user = currUser;
        subs.seriousness = Seriousness.VERY_SERIOUS
        subs.validate()
        subs.save(flush : true , failOnError : true)
    }

    def getTopRecentPosts() {
        def cri = Topic.createCriteria()

        def results = cri.list() {
            maxResults(3)
//            offset(0)
//            sort: "id", order: "desc"
        }
        return results
    }

    def getAllPosts() {
        def cri = Topic.createCriteria()

        def results = cri.list(){

        }
        Map m = ["key": results]
        return m as JSON
    }

}
