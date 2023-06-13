package helloworld

import Enum.Seriousness
import Enum.Visibility
import grails.converters.JSON

import grails.gorm.transactions.Transactional

import org.springframework.mail.MailSender
import org.springframework.mail.SimpleMailMessage
import java.security.SecureRandom

class TopicService {

    MailSender mailSender

    def saveTopicUsingCredentials(def params , User currUser) {
        if(params.topicName.length()>=128){
            return false
        }
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
        def topPost = Resource.createCriteria().list(){
            topic{
                eq("visibility" , Visibility.PUBLIC)
            }
            order("lastUpdated","desc")
            maxResults 5
        }
        println "%%%%%%%%%%%%%%%%%%%%%5" + topPost
        return topPost
    }

    def getAllPosts() {
        def cri = Topic.createCriteria()

        def results = cri.list(){}
        Map m = ["key": results]
        return m as JSON
    }

    def getTrendingPosts(User currUser){

        def trendingList = Resource.createCriteria().list(){
            projections {
                groupProperty("topic")
                rowCount("topicCount")
            }
            topic{
                eq("visibility" , Visibility.PUBLIC)
            }
            order("topicCount", "desc")
            maxResults(5)
        }
        println trendingList
        return trendingList
    }

//    def topRatingPosts() {
//
//    }

    def sendInvite(def params){
        println "params in send invite" + params.linkTopic
        println "params of mail in send invite" + params.userEmail
        try{
            String subject = "Invitation for the topic"
            String  mailtext = "This is invite for the topic--->" + params.linkTopic
            def msg = new SimpleMailMessage();
            msg.setFrom("vohraraghav@outlook.com")
            msg.setTo(params.userEmail)
            msg.setSubject(subject)
            msg.setText(mailtext)
            mailSender.send(msg)

            return true
        }
        catch(Exception e){
            println e
            return false
        }

    }
}
