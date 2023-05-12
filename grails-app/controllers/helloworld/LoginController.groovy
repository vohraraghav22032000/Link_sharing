package helloworld

class LoginController {

    def LoginService

    def index() {
        render(view:"index")
    }

    def loginUser(){

        String userInput = params.email

        User us = LoginService.checkUserExistence(userInput)

       if(params.password == us.password){
           if(us){
               session.username = us.username
               println "user created"
               println session.username
               redirect(url:"/dashboard")
           }
       }
        else{
            render "user does not exist"
        }

    }

    def logoutUser(){
        session.invalidate()
        redirect(url:"/")
    }
}
