package helloworld

import Enum.Seriousness

class subscriptionService {
    def topicSubscribedByUser(User currUser){

        println "User in totalSubscribedBy User" + currUser
        println "User Subscribed"
//        def cri = Subscription.createCriteria()
//
//        println "User present----->" + user
//        def results = cri.list() {
//            eq("user", currUser)
//           // eq("Topic",topic)
//        }
//
//        println "User Subscribed"
////        return results
//        def subscribed = Subscription.findAllByUser(currUser)
//        if(subscribed.size() == 0)
        return Subscription.findAllByUser(currUser)
    }


}
