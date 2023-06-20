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
    }

    def topicSubscribedByUser(){
        User user = User.findByUsername(session.username);
        def result = subscriptionService.topicSubscribedByUser(user)
        render result
    }

    def addSubscription(){
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
        def topic = Topic.get(params.topicId)
        if (topic) {
            User user = User.findByUsername(session.username);
            def deletedValue = Subscription.findByTopicAndUser(topic,user)
            deletedValue.delete(flush:true,failOnError : true)
            render(status: 200, text: 'Topic deleted')
        } else {
            render(status: 404, text: 'Topic not found')
        }
    }

    def updateSeriousness(){
        def subscription = Subscription.get(params.subscriptionId)
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
