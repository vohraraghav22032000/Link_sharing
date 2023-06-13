package helloworld

import Enum.Seriousness
import Enum.Visibility

class SubscriptionController {

    def subscriptionService;
    def topicService

    def index() {
        if(session.username==null){
            redirect(url :"/index")
            return
        }
//        User user = User.findByUsername(session.username);
//        render "user found" + user
//        def result = subscriptionService.topicSubscribedByUser(user)
//
//        render result

    }

    def topicSubscribedByUser(){
        User user = User.findByUsername(session.username);

        def result = subscriptionService.topicSubscribedByUser(user)

        render result
    }

    def addSubscription(){
//        println "params" + params.topicId
        def topic = Topic.get(params.topicId)
        if (topic) {
            User user = User.findByUsername(session.username);
            topicService.subscribedToTopic(topic,user)
            render(status: 200, text: 'Topic deleted')
        } else {
            render(status: 404, text: 'Topic not found')
        }
    }

    def deleteSubscription(){
        println "params in delete subscription" + params.topicId
        def topic = Topic.get(params.topicId)
        if (topic) {
            User user = User.findByUsername(session.username);
            def deletedValue = Subscription.findByTopicAndUser(topic,user)
            deletedValue.delete(flush:true,failOnError : true)

//            def subscriptionList = subscriptionService.topicSubscribedByUser(user)
//
//            println "topic unsubscribed successfully"

            render(status: 200, text: 'Topic deleted')
        } else {
            render(status: 404, text: 'Topic not found')
        }
    }

    def updateSeriousness(){
        println "params in update seriousness" + params
        println "params in subsscriptionId  " + params.subscriptionId

        def subscription = Subscription.get(params.subscriptionId)
        println "Subscription is " + subscription

        if (subscription) {
            if(params.selectedOption=='VERY_SERIOUS'){
                subscription.seriousness = Seriousness.VERY_SERIOUS
            }
            else if(params.selectedOption=='SERIOUS'){
                subscription.seriousness = Seriousness.SERIOUS
            }
            else if(params.selectedOption=='CASUAL'){
                subscription.seriousness = Seriousness.CASUAL
            }

            subscription.save(flush : true,failOnError : true)
            render(status: 200, text: 'Seriousness updated')
        } else {
            render(status: 404, text: 'Seriousness not updated')
        }
    }

}
