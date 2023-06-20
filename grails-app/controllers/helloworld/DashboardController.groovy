package helloworld

import Enum.Visibility

class DashboardController {

    def dashboardService
    def topicService
    def subscriptionService
    def searchService

    def index() {
        if(session.username == null){
            redirect(url :"/")
            return
        }
        if(params.search!=null){
            if(params.search.length()>128){
                flash.errorMessage = "search content should not exceed 128 characters"
                redirect(url : "/dashboard", model :['msg' : flash.errorMessage ])
            }
        }

        User user = User.findByUsername(session.username)
        Boolean isAdmin = user.admin

        List allTopics = []
        List allPublicTopics = Topic.createCriteria().list(){
            eq("visibility" , Visibility.PUBLIC)
        }

        List allPublicPrivateTopics = Topic.findAll()
        allTopics = isAdmin ? allPublicPrivateTopics : allPublicTopics
        allTopics = allTopics.sort { a, b -> a.name <=> b.name }

        def topicMap = dashboardService.createTopicMap(allTopics)

        def subscriptionList = subscriptionService.topicSubscribedByUser(user)
        def firstFiveSubscriptions = subscriptionList.take(Math.min(5, subscriptionList.size()))
        def subscriptionListName = subscriptionList.collect { subs-> subs.topic.name}

        def topicCreatedByUser = Topic.createCriteria().list(){eq("createdBy",user)}
        def topicCreatedByUserName = topicCreatedByUser.collect{topic-> topic.name}

        def recentList = topicService.getTopRecentPosts()
        def trendingList = topicService.getTrendingPosts(user)

        def topicCount = topicCreatedByUser.size()

        def subscribedCount = subscriptionList.size()

        def allResources
        if(params.search==null) {
            allResources = ReadingItem.createCriteria().list() {
                eq("isRead", false)
                eq("user", user)
            }
        }
        else{
            allResources = searchService.searchWithParams(params.search)
        }

        render (view: "index", model : [user : user , posts : recentList , topicCount : topicCount
        ,subscriptionList : subscriptionList , subscribedCount: subscribedCount , isAdmin : isAdmin
        ,trendingList : trendingList  , topicCreatedByUserList : topicCreatedByUser ,
        subscriptionListName : subscriptionListName , allTopics : allTopics , firstFiveSubscriptions : firstFiveSubscriptions,
        allResources : allResources , topicCreatedByUserName : topicCreatedByUserName,topicMap : topicMap])
    }

    def allUsers(){
        if(session.username == null){
            redirect(url :"/")
            return
        }
        def allTopics = Topic.findAll()
        def topicMap = dashboardService.createTopicMap(allTopics)

        User currUser = User.findByUsername(session.username)
        def isAdmin = currUser.admin

        User userProfile = User.findById((params.userId))

        def userAllTopics = Topic.createCriteria().list(){
            eq("createdBy",userProfile)
        }
        def userSubscriptions = userProfile.subscriptions
        def userResources = userProfile.resources
        def userPublicTopic =[]
        userAllTopics.each{ut->
            if(ut.visibility==Visibility.PUBLIC){
                userPublicTopic.add(ut)
            }
        }
        def userTopics
        if(currUser.admin || currUser==userProfile){
            userTopics = userAllTopics
        }
        else{
            userTopics = userPublicTopic
        }

        render(view:"allUsers" , model : [ userTopics : userTopics
            ,userResources : userResources , userSubscriptions: userSubscriptions, user : currUser
         , isAdmin: isAdmin , userProfile : userProfile , allTopics: allTopics , topicMap: topicMap])
    }
}
