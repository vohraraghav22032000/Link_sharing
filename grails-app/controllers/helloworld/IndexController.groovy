package helloworld

import Enum.Visibility

import java.util.Calendar
import grails.gorm.transactions.Transactional
import org.hibernate.criterion.Restrictions

class IndexController {

    def topicService
    def loginService
    def registerService

    def index() {

        if(session.username){
            redirect(url: "/dashboard")
            return
        }
        String timeFrame = params.timeFrame
        if(timeFrame==null){
            timeFrame="Today"
        }
        def recentList = topicService.getTopRecentPosts()

        def topRatingPost = ResourceRating.createCriteria().list {
            Calendar calendar = Calendar.getInstance()
            def startDate
            switch (timeFrame){
                case "Today" : startDate = calendar.clearTime()
                    break
                case "1 Week" : calendar.add(Calendar.DAY_OF_MONTH,-7)
                    startDate = calendar.clearTime()
                    break
                case "1 Month" : calendar.add(Calendar.MONTH , -1)
                    startDate = calendar.clearTime()
                    break
                case "1 Year" : calendar.add(Calendar.YEAR , -1)
                    startDate = calendar.clearTime()
                    break
                default:
                    startDate = calendar.clearTime()
            }
            resource{
                topic {
                    eq("visibility", Visibility.PUBLIC)
                }
                ge("dateCreated" , startDate.time)
                order("lastUpdated","desc")
            }
            order("score", "desc")
            maxResults(5)
        }

        render (view: "index", model :['posts' : recentList ,'topRatingPost' : topRatingPost
                                       ,'timeFrame' : timeFrame])
    }

    def registerUser(){
        if(params.password != params.confirmpassword){
            flash.errorMessage = "Password and Confirm Password are not matching"
            redirect(url : "/index", model :['msg' : flash.errorMessage ])
        }
        else if(params.password.length()<8){
            flash.errorMessage = "Password should contain minimum 8 characters"
            redirect(url : "/index", model :['msg' : flash.errorMessage ])
        }
        else{
            String userEmail = params.email
            String userUsername = params.username

            User us = loginService.checkUserExistence(userEmail,userUsername)
            if(us){
                flash.errorMessage = "User already exists"
                redirect(url : "/index", model :['msg' : flash.errorMessage ])
            }
            else{
                def allUsers = User.findAll()
                def count = allUsers.size()
                boolean countFlag = false
                if(count == 0){
                    countFlag = true
                }
                def flag = registerService.registerUserUsingCredentials(params,countFlag)
                if(flag){
                    flash.successMessage = "You are Registered successfully"
                    redirect(url : "/index", model :['msg' : flash.successMessage ])
                }
                else {
                    flash.errorMessage = "Please enter valid details"
                    redirect(url : "/index", model :['msg' : flash.errorMessage ])
                }
            }
        }

    }

    def loginUser(){
        String userEmail = params.email
        User us = loginService.checkUserExistence(userEmail,userEmail)

        if(us && params.password == us.password){
            if(us.active==false){
                flash.errorMessage = "You are deactivated by admin"
                redirect(url:"/index",model: [msg:flash.errorMessage])
            }
            else{
                session.username = us.username
                redirect(controller: 'dashboard', action: 'index')
            }
        }
        else{
            flash.errorMessage = "Please enter valid credentials"
            redirect(url : "/index", model :['msg' : flash.errorMessage ])
        }
    }
    def forgotPassword(){

        User user = User.findByEmail(params.userEmail)
        if(!user){
            flash.errorMessage = "user does not exist"
            redirect(url : "/index", model :['msg' : flash.errorMessage ])
        }
        else{
            def flag = registerService.resetPassword(params,user)
            if(flag){
                flash.successMessage = "Password reset link has been sent to your email"
                redirect(url : "/index", model :['msg' : flash.successMessage ])
            }
            else {
                flash.errorMessage = "Please enter valid email"
                redirect(url : "/index", model :['msg' : flash.errorMessage ])
            }
        }
    }

    def resetPasswordUsingLink(){
        render(view: 'resetPasswordUsingLink')
    }
}
