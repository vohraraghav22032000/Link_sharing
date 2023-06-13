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

        def allTopics = Topic.createCriteria().list {}

        allTopics = allTopics.sort { a, b -> a.name <=> b.name }

        def topicMap = dashboardService.createTopicMap(allTopics)

        User user = User.findByUsername(session.username)
        def isAdmin = user.admin

        def subscriptionList = subscriptionService.topicSubscribedByUser(user)
//        subscriptionList.topic*.resources.sort {it.lastUpdated}.reverse()


        def subscriptionListName = subscriptionList.collect { subs-> subs.topic.name}

        def topicCreatedByUser = Topic.createCriteria().list(){eq("createdBy",user)}
        def topicCreatedByUserName = topicCreatedByUser.collect{topic-> topic.name}

        def recentList = topicService.getTopRecentPosts()
        def trendingList = topicService.getTrendingPosts(user)

        def topicCount = topicCreatedByUser.size()

        def subscribedCount = subscriptionList.size()

        def allResources = ReadingItem.createCriteria().list(){
            eq("isRead",false)
            eq("user",user)
        }

        render (view: "index", model : [user : user , posts : recentList , topicCount : topicCount
        ,subscriptionList : subscriptionList , subscribedCount: subscribedCount , isAdmin : isAdmin
        ,trendingList : trendingList  , topicCreatedByUserList : topicCreatedByUser ,
        subscriptionListName : subscriptionListName , allTopics : allTopics ,
        allResources : allResources , topicCreatedByUserName : topicCreatedByUserName,topicMap : topicMap])
    }

    def allUsers(){
        def allTopics = Topic.createCriteria().list {}
        def topicMap = dashboardService.createTopicMap(allTopics)

        def allUsers = User.createCriteria().list(){}

        User currUser = User.findByUsername(session.username)
        def isAdmin = currUser.admin

        User userProfile = User.findById((params.userId))
        def userTopics = userProfile.topics
        def userSubscriptions = userProfile.subscriptions
        def userResources = userProfile.resources

        render(view:"allUsers" , model : [allUsers:allUsers , userTopics : userTopics
            ,userResources : userResources , userSubscriptions: userSubscriptions, user : currUser
         , isAdmin: isAdmin , userProfile : userProfile , allTopics: allTopics , topicMap: topicMap])
    }

    def resources(){
        if(session.username == null){
            redirect(url :"/")
            return
        }
        if(params.search.length()>128){
            flash.successMessage = "search content should not exceed 128 characters"
            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
        def allTopics = Topic.createCriteria().list {}

        allTopics = allTopics.sort { a, b -> a.name <=> b.name }

        def topicMap = dashboardService.createTopicMap(allTopics)
        User user = User.findByUsername(session.username)
        def isAdmin = user.admin

        def subscriptionList = subscriptionService.topicSubscribedByUser(user)
        def subscriptionListName = subscriptionList.collect { subs-> subs.topic.name}

        def topicCreatedByUser = Topic.createCriteria().list(){eq("createdBy",user)}
        def topicCreatedByUserName = topicCreatedByUser.collect{topic-> topic.name}

        def recentList = topicService.getTopRecentPosts()
        def trendingList = topicService.getTrendingPosts(user)

        def topicCount = topicCreatedByUser.size()

        def subscribedCount = subscriptionList.size()

        def searchOutput = searchService.searchWithParams(params.search)

        render (view: "index", model : [user : user , posts : recentList , topicCount : topicCount
            ,subscriptionList : subscriptionList , subscribedCount: subscribedCount , isAdmin : isAdmin
         ,trendingList : trendingList  , topicCreatedByUserList : topicCreatedByUser ,
          subscriptionListName : subscriptionListName , allTopics : allTopics ,
         allResources : searchOutput , topicCreatedByUserName : topicCreatedByUserName,topicMap : topicMap])
    }
}
