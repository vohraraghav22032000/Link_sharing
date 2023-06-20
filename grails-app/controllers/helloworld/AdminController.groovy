package helloworld

import Enum.Visibility

class AdminController {

    def subscriptionService
    def searchService
    def dashboardService

    def index() {
        if(session.username==null){
            redirect(url :"/")
            return
        }
        else{
            redirect(url :"/admin/profileView")
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
        def subscriptionList = subscriptionService.topicSubscribedByUser(user)
        def topicCount = Topic.createCriteria().count{
            eq("createdBy" , user)
        }
        def allTopicsCreatedByUser
        if(params.search==null){
            allTopicsCreatedByUser = Topic.createCriteria().list(){
                eq("createdBy" , user)
            }
        }
        else{
            allTopicsCreatedByUser = searchService.searchWithParamsTopicView(params.search,user)
        }

        def subscriptionListName = subscriptionList.collect { subs-> subs.topic.name}
        def topicCreatedByUserName = allTopicsCreatedByUser.collect{topic-> topic.name}
        def topicMap = dashboardService.createTopicMap(allTopicsCreatedByUser)
        def subscribedCount = subscriptionList.size()
        boolean isAdmin = user.admin
        render(view: "editProfile" , model : [isAdmin : isAdmin , subscriptionList : subscriptionList,
        subscriptionListName: subscriptionListName, topicCreatedByUserName: topicCreatedByUserName ,
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
            allResourcesByUser = ReadingItem.createCriteria().list() {
                and {
                    eq("isRead", false)
                    eq("user", user)
                }
            }
        }
        else{
            allResourcesByUser = searchService.searchWithParamsPostView(params.search,user)
        }

        def allTopicsCreatedByUser = Topic.createCriteria().list(){
            eq("createdBy" , user)
        }
        def allTopics = Topic.createCriteria().list{}

        def topicMap = dashboardService.createTopicMap(allTopics)
        boolean isAdmin = user.admin
        def subscriptionList = subscriptionService.topicSubscribedByUser(user)
        def topicCount = Topic.createCriteria().count{
            eq("createdBy" , user)
        }
        def subscriptionListName = subscriptionList.collect { subs-> subs.topic.name}
        def topicCreatedByUserName = allTopicsCreatedByUser.collect{topic-> topic.name}
        def subscribedCount = subscriptionList.size()
        render(view: "profile" , model : [isAdmin : isAdmin , subscriptionList : subscriptionList,
        topicCount : topicCount , user : user , topicsCreatedByUserList: allTopicsCreatedByUser,
        allResourcesByUser : allResourcesByUser ,  subscribedCount : subscribedCount,
        topicMap : topicMap, subscriptionListName : subscriptionListName
          ,allTopics: allTopics, topicCreatedByUserName : topicCreatedByUserName])
    }

    def usersView() {
        if(session.username == null){
            redirect(url :"/")
            return
        }

        User user = User.findByUsername(session.username);
        boolean isAdmin = user.admin
        def subscriptionList = subscriptionService.topicSubscribedByUser(user)
        def allUsers = User.findAll()
        render(view: "users" , model : [subscriptionList: subscriptionList, allUsers : allUsers , isAdmin : isAdmin ,user : user ])
    }

    def topicsView() {
        if(session.username == null){
            redirect(url :"/")
            return
        }

        def allTopics = Topic.createCriteria().list(){}
        User user = User.findByUsername(session.username);
        def subscriptionList = subscriptionService.topicSubscribedByUser(user)

        boolean isAdmin = user.admin
        render(view: "topics", model : [ subscriptionList: subscriptionList,isAdmin : isAdmin , allTopics : allTopics ,user : user])
    }

    def postsView(){
        if(session.username == null){
            redirect(url :"/")
            return
        }

        def allResource = Resource.createCriteria().list(){}
        User user = User.findByUsername(session.username);
        def subscriptionList = subscriptionService.topicSubscribedByUser(user)
        boolean isAdmin = user.admin
        render(view:"posts", model : [subscriptionList: subscriptionList,isAdmin : isAdmin , allResource : allResource,user : user])
    }
}
