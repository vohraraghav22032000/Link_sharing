package helloworld

import Enum.Visibility

class AuthenticationController {

    def topicService
    def loginService
    def registerService
    def documentResourceService

    def index(){

        if(session.username!=null){
            println "seeion ----------> " + session
            redirect(url: "/dashboard/index");
            return
        }
        String timeFrame = params.timeFrame
        if(timeFrame==null){
            timeFrame="Today"
        }
        List recentList = topicService.getTopRecentPosts()
        List topRatingPost = documentResourceService.getTopRatingPost(timeFrame)

        render (view: "auth", model :['posts' : recentList ,'topRatingPost' : topRatingPost
                                       ,'timeFrame' : timeFrame])
    }

    def registerUser(){

        if(params.password != params.confirmpassword){
            flash.errorMessage = "Password and Confirm Password are not matching"
            redirect(url : "/authentication", model :['msg' : flash.errorMessage ])
        }
        else if(params.password.length()<8){
            flash.errorMessage = "Password should contain minimum 8 characters"
            redirect(url : "/authentication", model :['msg' : flash.errorMessage ])
        }
        else{
            String userEmail = params.email
            String userUsername = params.username

            User us = loginService.checkUserExistence(userEmail,userUsername)
            if(us){
                flash.errorMessage = "User already exists"
                redirect(url : "/authentication", model :['msg' : flash.errorMessage ])
            }
            else{
                List allUsers = User.findAll()
                int count = allUsers.size()
                boolean countFlag = false
                if(count == 0){
                    countFlag = true
                }
                def flag = registerService.registerUserUsingCredentials(params,countFlag)
                if(flag){
                    flash.successMessage = "You are Registered successfully"
                    redirect(url : "/authentication", model :['msg' : flash.successMessage ])
                }
                else {
                    flash.errorMessage = "Please enter valid details"
                    redirect(url : "/authentication", model :['msg' : flash.errorMessage ])
                }
            }
        }

    }

    def loginUser(){
        String userEmail = params.email
        User user = loginService.checkUserExistence(userEmail,userEmail)

        if(user && params.password == user.password){
            if(user.active==false){
                flash.errorMessage = "You are deactivated by admin"
                redirect(url:"/authentication",model: [msg:flash.errorMessage])
            }
            else{
                session.username = user.username
                redirect(controller: 'dashboard', action: 'index')
            }
        }
        else{
            flash.errorMessage = "Please enter valid credentials"
            redirect(url : "/authentication", model :['msg' : flash.errorMessage ])
        }
    }

    def forgotPassword(){

        User user = User.findByEmail(params.userEmail)
        if(!user){
            flash.errorMessage = "user does not exist"
            redirect(url : "/authentication", model :['msg' : flash.errorMessage ])
        }
        else{
            boolean flag = registerService.resetPassword(params)
            if(flag){
                flash.successMessage = "Password reset link has been sent to your email"
                redirect(url : "/authentication", model :['msg' : flash.successMessage ])
            }
            else {
                flash.errorMessage = "Please enter valid email"
                redirect(url : "/authentication", model :['msg' : flash.errorMessage ])
            }
        }
    }

    def resetPasswordUsingLink(){
        render(view: 'resetPasswordUsingLink')
    }
}
