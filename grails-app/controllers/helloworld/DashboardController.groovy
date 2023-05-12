package helloworld

class DashboardController {

    def dashboardService
    def topicService
    def subscriptionService


    /*
    Annotations : @Bean,@Component,@RequestParams,@PathVariable,@RequestBody,@ResponseBody
    ,@Qualifier,@Controller,@SpringAutoConfiguration,@Configuration,@service,@Repository,@Ignore
    @componentIcon
    * */
    def index() {
        User user = User.findByUsername(session.username)
        def isAdmin = user.admin

        println "user is admin or not" + isAdmin

        println "user in dashboard--->" + user
        def subscriptionList = subscriptionService.topicSubscribedByUser(user)
        def recentList = topicService.getTopRecentPosts()
        def topicCount = Topic.createCriteria().count{
            eq("createdBy" , user)
        }
        def subscribedCount = subscriptionService.topicSubscribedByUser(user)
//        println "user: ${user.firstname}, topicCount: ${topicCount}"
//        println "--->" + session.username
        render (view: "index", model : [user : user , posts : recentList , topicCount : topicCount
        ,subscriptionList : subscriptionList , subscribedCount: subscribedCount , isAdmin : isAdmin]  )
    }
}
