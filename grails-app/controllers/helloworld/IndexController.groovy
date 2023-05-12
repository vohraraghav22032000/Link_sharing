package helloworld

class IndexController {

    def topicService

    def index() {
        def recentList = topicService.getTopRecentPosts()

        render (view: "index", model : ['posts' : recentList ] )
    }
}
