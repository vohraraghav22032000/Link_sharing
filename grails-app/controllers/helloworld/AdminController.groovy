package helloworld

class AdminController {

    def index() {

    }

    def profileView() {
        User user = User.findByUsername(session.username);
        boolean isAdmin = user.isAdmin
        println " user in admin present" + isAdmin
        render(view: "profile" , model : [isAdmin : isAdmin])
    }

    def usersView() {
        def allUsers = User.createCriteria().list(){};
        render(view: "users" , model : [allUsers : allUsers])
    }

    def topicsView() {
        render(view: "topics")
    }

    def postsView(){
        render(view:"posts")
    }
}
