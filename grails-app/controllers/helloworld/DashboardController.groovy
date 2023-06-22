package helloworld

import Enum.Visibility

class DashboardController {

    def dashboardService
    def topicService
    def subscriptionService
    def searchService
    def readingItemService

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

        List allTopics = Topic.findAll()
        Map topicMap = dashboardService.createTopicMap(allTopics)
        List allPublicTopics = Topic.createCriteria().list(){
            eq("visibility" , Visibility.PUBLIC)
        }

        List allPublicPrivateTopics = Topic.findAll()
        allTopics = isAdmin ? allPublicPrivateTopics : allPublicTopics
        allTopics = allTopics.sort { a, b -> a.name <=> b.name }

        List subscriptionList = subscriptionService.topicSubscribedByUser(user)
        List firstFiveSubscriptions = subscriptionList.take(Math.min(5, subscriptionList.size()))
        List subscriptionListId = subscriptionList.collect { subs-> subs.topic.id}

        List topicCreatedByUser = topicService.topicCreatedByUser(user)
        List topicCreatedByUserId = topicCreatedByUser.collect{topic-> topic.id}
        List trendingList = topicService.getTrendingPosts(user)
        int topicCount = topicCreatedByUser.size()

        int subscribedCount = subscriptionList.size()

        List allResources
        if(params.search==null) {
            allResources = readingItemService.readingItemOfUser(user)
        }
        else{
            allResources = searchService.searchWithParams(params.search)
        }

        render (view: "index", model : [user : user ,  topicCount : topicCount
        ,subscriptionList : subscriptionList , subscribedCount: subscribedCount , isAdmin : isAdmin
        ,trendingList : trendingList  , topicCreatedByUserList : topicCreatedByUser ,
        subscriptionListId : subscriptionListId , allTopics : allTopics , firstFiveSubscriptions : firstFiveSubscriptions,
        allResources : allResources , topicCreatedByUserId : topicCreatedByUserId,topicMap : topicMap])
    }

    def allUsers(){
        if(session.username == null){
            redirect(url :"/")
            return
        }
        List allTopics = Topic.findAll()
        Map topicMap = dashboardService.createTopicMap(allTopics)

        User currUser = User.findByUsername(session.username)
        boolean isAdmin = currUser.admin

        User userProfile = User.findById((params.userId))

        List userAllTopics = topicService.topicCreatedByUser(userProfile)
        def userSubscriptions = userProfile.subscriptions
        def userResources = userProfile.resources
        
        List userPublicTopic =[]
        userAllTopics.each{topic->
            if(topic.visibility==Visibility.PUBLIC){
                userPublicTopic.add(topic)
            }
        }
        List userTopics
        userTopics = (currUser.admin || currUser==userProfile)? userAllTopics : userPublicTopic

        render(view:"allUsers" , model : [ userTopics : userTopics
            ,userResources : userResources , userSubscriptions: userSubscriptions, user : currUser
         , isAdmin: isAdmin , userProfile : userProfile , allTopics: allTopics , topicMap: topicMap])
    }
}
