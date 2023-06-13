package helloworld

import Enum.Visibility

class TopicShowController {

    def subscriptionService
    def dashboardService

    def index() {
        def topic = Topic.get(Integer.parseInt(params.topicId))

        User user = null
        def isAdmin = false
        def topicCreatedByUser = null
        def topicCreatedByUserName = null
        def subscriptionList = null
        def subscriptionListName = null
        if(session.username){
            user = User.findByUsername(session.username)
            subscriptionList = subscriptionService.topicSubscribedByUser(user)
            isAdmin = user.admin
            topicCreatedByUser = Topic.createCriteria().list(){eq("createdBy",user)}
            topicCreatedByUserName = topicCreatedByUser.collect{it-> it.name}
            subscriptionListName = subscriptionList.collect { subs-> subs.topic.name}
        }

        def allTopics = Topic.createCriteria().list(){}
        def topicMap = dashboardService.createTopicMap(allTopics)
        def allSubUser = topic.subscriptions*.user
        def allSubUserMap = [:]
        allSubUser.each { us ->
            def subscribedCount = us.subscriptions.size()
            def topicCount = us.topics.size()
            allSubUserMap[us] = [subscribedCountOfUser: subscribedCount, topicCountOfUser: topicCount ]
        }

        def topicPosts = Resource.createCriteria().list(){
            eq("topic",topic)
            order("lastUpdated","desc")
        }

        if (topic) {
            render(view:"index" ,model: [subscriptionList : subscriptionList , topic:topic,allSubUser:allSubUser,topicPosts : topicPosts
            ,user : user , topicMap : topicMap, allSubUserMap :allSubUserMap,isAdmin : isAdmin ,
             subscriptionListName : subscriptionListName ,topicCreatedByUser : topicCreatedByUser , topicCreatedByUserName : topicCreatedByUserName])
        } else {
            redirect(url:"/dashboard")
        }
    }
}
