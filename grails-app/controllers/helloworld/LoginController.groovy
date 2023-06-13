package helloworld

class LoginController {

    def LoginService

    def index() {
        if(session.username!=null){
            redirect(url :"/dashboard")
            return
        }
        render(view:"index")
    }

    def logoutUser(){
        flash.loggedIn = false
        session.invalidate()
        redirect(url:"/")
    }
}
