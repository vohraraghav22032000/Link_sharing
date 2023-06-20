package helloworld

class PostShowController {
    def subscriptionService
    def topicService
    def dashboardService

    def index() {

        User user = null
        def recentList = topicService.getTopRecentPosts()
        Integer alreadyRatedScore
        def subscriptionListName = null

        def subscriptionList = null
        def isAdmin = false

        def allTopics = Topic.createCriteria().list(){}

        def topicMap = dashboardService.createTopicMap(allTopics)
        def topic = Topic.get(Integer.parseInt(params.topicId))
        def resource = Resource.get(Integer.parseInt(params.resourceId))
        def allSubUser = Subscription.createCriteria().list(){
            projections{
                property("user")
            }
            eq("topic",topic)
        }
        def trendingList = topicService.getTrendingPosts()
        def numberOfUsersRatedResource = ResourceRating.createCriteria().list(){
            eq("resource",resource)
        }
        Float averageScore = 0.0
        Integer totalSize = numberOfUsersRatedResource.size()
        numberOfUsersRatedResource.each{rating->
            averageScore += rating.score
        }
        averageScore /= (Float)totalSize

        if(session.username){
            user = User.findByUsername(session.username)
            subscriptionList = subscriptionService.topicSubscribedByUser(user)
            subscriptionListName = subscriptionList.collect { subs->
                subs.topic.name
            }
            isAdmin = user.admin
            ResourceRating resourceRating1 = ResourceRating.findByUserAndResource(user,resource);
            if(resourceRating1){
                alreadyRatedScore = resourceRating1.score
            }
        }
        def topicPosts = Resource.createCriteria().list(){eq("topic",topic)}
        if(topic && resource){
            render(view:"index" ,model: [subscriptionList : subscriptionList ,topic:topic,allSubUser:allSubUser,
               topicPosts : topicPosts , user:user , isAdmin : isAdmin
               , subscriptionListName : subscriptionListName , trendingList : trendingList , topicMap : topicMap,
               resource : resource,posts : recentList , alreadyRatedScore : alreadyRatedScore,
                   averageScore : averageScore,numberOfUsersRatedResource : numberOfUsersRatedResource])
        }
        else{
            redirect(url:"/dashboard")
        }
    }
}
