package helloworld

import Enum.Visibility

class SearchController {
    def topicService
    def subscriptionService
    def searchService
    def dashboardService


    def index() {
        if(session.username == null){
            redirect(url :"/authentication")
            return
        }
        if(params.search.length()>128){
            flash.errorMessage= "search content should not exceed 128 characters"
            redirect(url : "/dashboard", model :['msg' : flash.errorMessage ])
        }
        User user = User.findByUsername(session.username)
        if(!user.admin && params.search.length()==0){
            flash.errorMessage = "please enter some text"
            redirect(url : "/dashboard", model :['msg' : flash.errorMessage])
        }
        List allTopics = Topic.findAll()
        allTopics = allTopics.sort { a, b -> a.name <=> b.name }
        Map topicMap = dashboardService.createTopicMap(allTopics)
        List trendingList = topicService.getTrendingPosts(user)
        List subscriptionList = subscriptionService.topicSubscribedByUser(user)
        boolean isAdmin = user.admin
        List subscriptionListId = subscriptionList.collect { subs-> subs.topic.id}
        List recentList = topicService.getTopRecentPosts()
        List allPosts = ReadingItem.createCriteria().list(){
            eq("isRead" , false)
        }
        List topRatingPost = ResourceRating.createCriteria().list(){
            order("score","desc")
            resource{
                topic{
                    eq("visibility", Visibility.PUBLIC)
                }
            }
            maxResults 5
        }

        List searchOutput = searchService.searchWithParams(params.search)

        render (view: "index",model: [recentList : recentList , trendingList : trendingList,
         subscriptionList : subscriptionList , isAdmin : isAdmin , user : user ,allPosts : allPosts,
        allTopics : allTopics , topicMap : topicMap ,  searchOutput : searchOutput,
               topRatingPost : topRatingPost,subscriptionListId : subscriptionListId])

    }

    def withoutLogin(){
        if(params.search.length()>128){
            flash.errorMessage = "search content should not exceed 128 characters"
            redirect(url : "/authentication", model :['msg' : flash.errorMessage ])
        }
        List recentList = searchService.searchRecentListWithoutLogin(params.search)
        List topRatingPost = searchService.searchtopRatingPostWihoutLogin(params.search)
        render(view : "withoutLogin",model:[recentList: recentList , topRatingPost: topRatingPost])
    }
}
