package helloworld

import Enum.Visibility

class TopicShowController {

    def subscriptionService
    def dashboardService

    def index() {
        def topic = Topic.get(Integer.parseInt(params.topicId))
        if(params.search!=null){
            if(params.search.length()>128){
                flash.errorMessage = "search content should not exceed 128 characters"
                redirect(url : "/topicShow", model :['msg' : flash.errorMessage ,topicId : params.topicId])
            }
        }

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

        def topicPosts

        if(params.search==null) {
            topicPosts = Resource.createCriteria().list() {
                eq("topic", topic)
                order("lastUpdated", "desc")

            }
        }
        else{
            topicPosts = Resource.createCriteria().list(){
                and{
                    eq("topic", topic)
                    ilike('description', "%$params.search%")
                }
            }
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
