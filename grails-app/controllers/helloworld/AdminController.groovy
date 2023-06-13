package helloworld

import Enum.Visibility

class AdminController {

    def subscriptionService
    def searchService
    def dashboardService

    def index() {
        def session = request.getSession()
        if(!session){
            response.sendRedirect(url:"/index");
            return
        }
//        if(session.username==null){
//            redirect(url :"/index")
//            return
//        }
    }

    def editProfileView(){
        User user = User.findByUsername(session.username);
        def subscriptionList = subscriptionService.topicSubscribedByUser(user)
        def topicCount = Topic.createCriteria().count{
            eq("createdBy" , user)
        }
        def allTopicsCreatedByUser = Topic.createCriteria().list(){
            eq("createdBy" , user)
        }
        def subscriptionListName = subscriptionList.collect { subs->
            subs.topic.name
        }
        def topicCreatedByUserName = allTopicsCreatedByUser.collect{topic->
            topic.name
        }
        def topicMap = dashboardService.createTopicMap(allTopicsCreatedByUser)
//        println "--------> topic map in dashboard controller -----edit----->" + topicMap
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
        User user = User.findByUsername(session.username);
        def allResourcesByUser = ReadingItem.createCriteria().list(){
            and{
                eq("isRead",false)
                eq("user" , user)
            }
        }
        def allTopicsCreatedByUser = Topic.createCriteria().list(){
            eq("createdBy" , user)
        }
        def allTopics = Topic.createCriteria().list{}

        def topicMap = dashboardService.createTopicMap(allTopics)
//        println "--------> topic map in dashboard controller -----profile----->" + topicMap

        boolean isAdmin = user.admin
        def subscriptionList = subscriptionService.topicSubscribedByUser(user)
        def topicCount = Topic.createCriteria().count{
            eq("createdBy" , user)
        }
        def subscriptionListName = subscriptionList.collect { subs->
            subs.topic.name
        }
        def topicCreatedByUserName = allTopicsCreatedByUser.collect{topic->
            topic.name
        }
        println " topic Created by username------------>" + topicCreatedByUserName
        println " subscription list name -------------->" + subscriptionListName
        def subscribedCount = subscriptionList.size()
        render(view: "profile" , model : [isAdmin : isAdmin , subscriptionList : subscriptionList,
        topicCount : topicCount , user : user , topicsCreatedByUserList: allTopicsCreatedByUser,
        allResourcesByUser : allResourcesByUser ,  subscribedCount : subscribedCount,
        topicMap : topicMap, subscriptionListName : subscriptionListName
          ,allTopics: allTopics, topicCreatedByUserName : topicCreatedByUserName])
    }

    def profileTopicView(){
        if(session.username == null){
            redirect(url :"/")
            return
        }
        User user = User.findByUsername(session.username);
        def subscriptionList = subscriptionService.topicSubscribedByUser(user)
        def topicCount = Topic.createCriteria().count{
            eq("createdBy" , user)
        }
        def allTopicsCreatedByUser = Topic.createCriteria().list(){
            eq("createdBy" , user)
        }
        def searchOutput = searchService.searchWithParamsTopicView(params.search,user)
        println searchOutput
        def subscriptionListName = subscriptionList.collect { subs->
            subs.topic.name
        }
        def topicCreatedByUserName = allTopicsCreatedByUser.collect{topic->
            topic.name
        }
        def topicMap = dashboardService.createTopicMap(allTopicsCreatedByUser)
//        println "--------> topic map in dashboard controller -----edit----->" + topicMap
        def subscribedCount = subscriptionList.size()
        boolean isAdmin = user.admin
        render(view: "editProfile" , model : [isAdmin : isAdmin , subscriptionList : subscriptionList,
                                              subscriptionListName: subscriptionListName, topicCreatedByUserName: topicCreatedByUserName ,
                                              topicCount : topicCount , user : user , topicMap: topicMap ,
                                              topicsCreatedByUserList : searchOutput , subscribedCount: subscribedCount])
    }

    def profilePostView(){
        if(session.username == null){
            redirect(url :"/")
            return
        }
        User user = User.findByUsername(session.username);
        if(params.search.length()>128){
            flash.successMessage = "search content should not exceed 128 characters"
            redirect(url : "/admin/profileView", model :['msg' : flash.successMessage ])
        }
        def searchOutput = searchService.searchWithParamsPostView(params.search,user)

        def allTopicsCreatedByUser = Topic.createCriteria().list(){
            eq("createdBy" , user)
        }
        def allTopics = Topic.createCriteria().list{}
        def topicMap = dashboardService.createTopicMap(allTopics)
//        println "--------> topic map in dashboard controller -----PostView----->" + topicMap

        boolean isAdmin = user.admin
        def subscriptionList = subscriptionService.topicSubscribedByUser(user)
        def topicCount = Topic.createCriteria().count{
            eq("createdBy" , user)
        }
        def subscriptionListName = subscriptionList.collect { subs->
            subs.topic.name
        }
        def topicCreatedByUserName = allTopicsCreatedByUser.collect{topic->
            topic.name
        }
        println " topic Created by username------------>" + topicCreatedByUserName
        println " subscription list name -------------->" + subscriptionListName
        def subscribedCount = subscriptionList.size()
        render(view: "profile" , model : [isAdmin : isAdmin , subscriptionList : subscriptionList,
                                          topicCount : topicCount , user : user , topicsCreatedByUserList: allTopicsCreatedByUser,
                                          allResourcesByUser : searchOutput ,  subscribedCount : subscribedCount,
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
        println " user in admin present" + isAdmin
        def subscriptionList = subscriptionService.topicSubscribedByUser(user)
        def allUsers = User.createCriteria().list(){};
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
      //  render allResource
        User user = User.findByUsername(session.username);
        def subscriptionList = subscriptionService.topicSubscribedByUser(user)
        boolean isAdmin = user.admin
        render(view:"posts", model : [subscriptionList: subscriptionList,isAdmin : isAdmin , allResource : allResource,user : user])
    }
}
