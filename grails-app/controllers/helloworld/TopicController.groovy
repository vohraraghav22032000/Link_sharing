package helloworld

class TopicController {

    def topicService

    def index() {
        //render "hi"
        //render "view: '/views/layouts/recentShares', model: [posts: result]"
        //render "view : '/views/layout/recentShares'"
        def myList = topicService.getTopRecentPosts()
        //def recentList = topicService.getAllPosts()
        render recentList
        //[posts: myList]
       // render(template: '/layouts/recentShares' , model : [abc: "", posts : [1, 2]])
    }

    def saveTopic(){
//        println "in save topic using credentials " + session.username
        User user = User.findByUsername(session.username);
//        println " user is " + user

        boolean flag = topicService.saveTopicUsingCredentials(params , user)

        if(flag){
            //render("Your Topic is saved successfully")
            redirect(url :"/dashboard")
        }
        else{
            render("Some Error has been occurred")
        }
    }

    def getAllPosts(){
        def result = topicService.getAllPosts()
        render result
    }

//
//    def posts(){
//
//        render "Hello Topics"
//        def result = topicService.getTopRecentPosts()
//        return result
//        render 'hi'
//        render " result from topicService" + result
//        [posts : result]
//
//        render result
//        render(template: '/layouts/recentShares' , model : [posts : result])
//    }

}
