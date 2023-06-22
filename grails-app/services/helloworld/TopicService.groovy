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

    boolean saveTopicUsingCredentials(def params , User currUser) {
        if(params.topicName.length()>=128){
            return false
        }
        Topic topic = new Topic();
        topic.name = params.topicName;
        topic.createdBy = currUser

        if(params.visibility == 'public'){
            topic.visibility = Visibility.PUBLIC
        }
        else{
            topic.visibility = Visibility.PRIVATE
        }
        if(topic.validate()){
            topic.save(flush : true , failOnError : true)
            subscribedToTopic(topic,currUser)
            return true
        }
        else{
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

    List getTopRecentPosts() {
        def topPost = Resource.createCriteria().list(){
            topic{
                eq("visibility" , Visibility.PUBLIC)
            }
            order("lastUpdated","desc")
            maxResults 5
        }
        return topPost
    }

    List getTrendingPosts(User currUser){
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
        return trendingList
    }

    boolean sendInvite(def params){
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

    List topicCreatedByUser(User currUser){
        return Topic.createCriteria().list(){eq("createdBy",currUser)}
    }
}
