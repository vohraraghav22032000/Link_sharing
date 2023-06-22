package helloworld

import Enum.Visibility

class AdminController {

    def subscriptionService
    def searchService
    def dashboardService
    def topicService
    def readingItemService

    def index() {
        if(session.username==null){
            redirect(url :"/")
            return
        }
    }

    def editProfileView(){
        if(session.username == null){
            redirect(url :"/")
            return
        }
        if(params.search!=null){
            if(params.search.length()>128){
                flash.errorMessage = "search content should not exceed 128 characters"
                redirect(url : "/admin/editProfileView", model :['msg' : flash.errorMessage ])
            }
        }
        User user = User.findByUsername(session.username);
        List subscriptionList = subscriptionService.topicSubscribedByUser(user)
        int topicCount = Topic.createCriteria().count{
            eq("createdBy" , user)
        }
        List allTopics = Topic.findAll()
        List allTopicsCreatedByUser
        if(params.search==null){
            allTopicsCreatedByUser = topicService.topicCreatedByUser(user)
        }
        else{
            allTopicsCreatedByUser = searchService.searchWithParamsTopicView(params.search,user)
        }

        List subscriptionListId = subscriptionList.collect { subs-> subs.topic.id}
        List topicCreatedByUserId = allTopicsCreatedByUser.collect{topic-> topic.id}
        Map topicMap = dashboardService.createTopicMap(allTopics)
        int subscribedCount = subscriptionList.size()
        boolean isAdmin = user.admin
        render(view: "editProfile" , model : [isAdmin : isAdmin , subscriptionList : subscriptionList,
        subscriptionListId : subscriptionListId, topicCreatedByUserId: topicCreatedByUserId ,
        topicCount : topicCount , user : user , topicMap: topicMap ,
               topicsCreatedByUserList : allTopicsCreatedByUser , subscribedCount: subscribedCount])
    }

    def profileView() {
        if(session.username == null){
            redirect(url :"/")
            return
        }
        if(params.search!=null){
            if(params.search.length()>128){
                flash.errorMessage = "search content should not exceed 128 characters"
                redirect(url : "/admin/profileView", model :['msg' : flash.errorMessage ])
            }
        }
        User user = User.findByUsername(session.username);

        def allResourcesByUser
        if(params.search==null){
            allResourcesByUser = readingItemService.readingItemOfUser(user)
        }
        else{
            allResourcesByUser = searchService.searchWithParamsPostView(params.search,user)
        }

        List allTopicsCreatedByUser = topicService.topicCreatedByUser(user)
        def allTopics = Topic.findAll()

        Map topicMap = dashboardService.createTopicMap(allTopics)
        boolean isAdmin = user.admin
        List subscriptionList = subscriptionService.topicSubscribedByUser(user)
        int topicCount = Topic.createCriteria().count{
            eq("createdBy" , user)
        }
        List subscriptionListId = subscriptionList.collect { subs-> subs.topic.id }
        List topicCreatedByUserId = allTopicsCreatedByUser.collect{topic-> topic.id}
        int subscribedCount = subscriptionList.size()
        render(view: "profile" , model : [isAdmin : isAdmin , subscriptionList : subscriptionList,
        topicCount : topicCount , user : user , topicsCreatedByUserList: allTopicsCreatedByUser,
        allResourcesByUser : allResourcesByUser ,  subscribedCount : subscribedCount,
        topicMap : topicMap, subscriptionListId : subscriptionListId
          ,allTopics: allTopics, topicCreatedByUserId : topicCreatedByUserId])
    }

    def usersView() {
        if(session.username == null){
            redirect(url :"/")
            return
        }
        User user = User.findByUsername(session.username);
        boolean isAdmin = user.admin
        List subscriptionList = subscriptionService.topicSubscribedByUser(user)
        List allUsers = User.findAll()
        render(view: "users" , model : [subscriptionList: subscriptionList, allUsers : allUsers , isAdmin : isAdmin ,user : user ])
    }

    def topicsView() {
        if(session.username == null){
            redirect(url :"/")
            return
        }
        List allTopics = Topic.findAll()
        User user = User.findByUsername(session.username);
        List subscriptionList = subscriptionService.topicSubscribedByUser(user)
        boolean isAdmin = user.admin
        render(view: "topics", model : [ subscriptionList: subscriptionList,isAdmin : isAdmin , allTopics : allTopics ,user : user])
    }

    def postsView(){
        if(session.username == null){
            redirect(url :"/")
            return
        }

        List allResource = Resource.findAll()
        User user = User.findByUsername(session.username);
        List subscriptionList = subscriptionService.topicSubscribedByUser(user)
        boolean isAdmin = user.admin
        render(view:"posts", model : [subscriptionList: subscriptionList,isAdmin : isAdmin , allResource : allResource,user : user])
    }
}
