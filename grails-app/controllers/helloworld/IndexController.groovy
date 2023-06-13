package helloworld

import Enum.Visibility

import java.util.Calendar
import grails.gorm.transactions.Transactional
import org.hibernate.criterion.Restrictions

class IndexController {

    def topicService
    def LoginService
    def registerService



    def index() {

        if(session.username){
            println "&&&&&&&&&&&&&&&&&&&&&&&&&&"
            redirect(url: "/dashboard")
            return
        }
        println "params in index/index--------->" + params
        String timeFrame = params.timeFrame

        if(timeFrame==null){
            timeFrame="Today"
        }
        println "value of time frame is---------->" + timeFrame
        def recentList = topicService.getTopRecentPosts()
        def topRatingPost = ResourceRating.createCriteria().list {
            resource{
                topic {
                    eq("visibility", Visibility.PUBLIC)
                }
                order("lastUpdated","desc")
            }
            order("score", "desc")
            maxResults(5)
        }

        println "top rating post------------> $topRatingPost"

        render (view: "index", model :['posts' : recentList ,'topRatingPost' : topRatingPost
        ,'timeFrame' : timeFrame])
    }

    def registerUser(){

        if(params.password != params.confirmpassword){
            flash.successMessage = "Password and Confirm Password are not matching"
            redirect(url : "/index", model :['msg' : flash.successMessage ])
        }
        else if(params.password.length()<8){
            flash.successMessage = "Password should contain minimum 8 characters"
            redirect(url : "/index", model :['msg' : flash.successMessage ])
        }
        else{
            String userEmail = params.email
            String userUsername = params.username

            User us = LoginService.checkUserExistence(userEmail,userUsername)
            if(us){
                flash.successMessage = "User already exists"
                redirect(url : "/index", model :['msg' : flash.successMessage ])
            }
            else{
                def allUsers = User.createCriteria().list(){}
                def count = allUsers.size()
                boolean countflag = false
                if(count == 0){
                    countflag = true
                }
                def flag = registerService.registerUserUsingCredentials(params,countflag)
                if(flag){
                    flash.successMessage = "You are Registered successfully"
                    redirect(url : "/index", model :['msg' : flash.successMessage ])
                }
                else {
                    flash.successMessage = "Please enter valid details"
                    redirect(url : "/index", model :['msg' : flash.successMessage ])
                }
            }
        }

    }


    def loginUser(){

        String userEmail = params.email

        User us = LoginService.checkUserExistence(userEmail,userEmail)

        if(us && params.password == us.password){
            if(us.active==false){
//                def recentList = topicService.getTopRecentPosts()
                flash.successMessage = "You are deactivated by admin"
                redirect(url:"/index",model: [msg:flash.successMessage])
            }
            else{
                session.username = us.username
                flash.loggedIn = true
                redirect(controller: 'dashboard', action: 'index')

            }
        }
        else{
            flash.successMessage = "Please enter valid credentials"
            redirect(url : "/index", model :['msg' : flash.successMessage ])
        }

    }
    def forgotPassword(){

        User user = User.findByEmail(params.userEmail)
        if(!user){
            flash.successMessage = "user doesnot exist"
            redirect(url : "/index", model :['msg' : flash.successMessage ])
        }
        else if(params.newPassword.length()<8){
            flash.successMessage = "password should contain minimum 8 characters"
            redirect(url : "/index", model :['msg' : flash.successMessage ])
        }
        else{
            def flag = registerService.resetPassword(params,user)
            if(flag){
                flash.successMessage = "password updated successfully"
                redirect(url : "/index", model :['msg' : flash.successMessage ])
            }
            else {
                flash.successMessage = "Password and confirm password not matching"
                redirect(url : "/index", model :['msg' : flash.successMessage ])
            }
        }

    }

}
