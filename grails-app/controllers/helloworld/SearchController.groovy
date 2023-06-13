package helloworld

import Enum.Visibility

class SearchController {
    def topicService
    def subscriptionService
    def searchService
    def dashboardService


    def index() {
//        println "params in search function-----------###################------->" + params
        if(session.username == null){
            redirect(url :"/index")
            return
        }
        if(params.search.length()>128){
            flash.successMessage = "search content should not exceed 128 characters"
            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
        User user = User.findByUsername(session.username)
        def allTopics = Topic.createCriteria().list {}

        allTopics = allTopics.sort { a, b -> a.name <=> b.name }

        def topicMap = dashboardService.createTopicMap(allTopics)

        def trendingList = topicService.getTrendingPosts(user)
        def subscriptionList = subscriptionService.topicSubscribedByUser(user)
        def isAdmin = user.admin
        def subscriptionListName = subscriptionList.collect { subs->
            subs.topic.name
        }
        def recentList = topicService.getTopRecentPosts()
        def allPosts = ReadingItem.createCriteria().list(){
            eq("isRead" , false)
        }

        def topRatingPost = ResourceRating.createCriteria().list(){
            order("score","desc")
            resource{
                topic{
                    eq("visibility", Visibility.PUBLIC)
                }
            }
            maxResults 5
        }


        def searchOutput = searchService.searchWithParams(params.search)
        println "searchOutput -----> $searchOutput"


        render (view: "index",model: [recentList : recentList , trendingList : trendingList,
         subscriptionList : subscriptionList , isAdmin : isAdmin , user : user ,allPosts : allPosts,
        allTopics : allTopics , topicMap : topicMap ,  searchOutput : searchOutput,
               topRatingPost : topRatingPost,subscriptionListName : subscriptionListName])

    }

    def withoutLogin(){

        if(params.search.length()>128){
            flash.successMessage = "search content should not exceed 128 characters"
            redirect(url : "/index", model :['msg' : flash.successMessage ])
        }
//        def recentList = topicService.getTopRecentPosts()
        def recentList = searchService.searchRecentListWithoutLogin(params.search)
        def topRatingPost = ResourceRating.createCriteria().list(){
            order("score","desc")
            resource{
                topic{
                    eq("visibility", Visibility.PUBLIC)
                }
            }
            maxResults 5
        }
        render(view : "withoutLogin",model:[recentList: recentList , topRatingPost: topRatingPost])
    }
    def getDownloadName() {
        return "${name}.${extension}"
    }

}
