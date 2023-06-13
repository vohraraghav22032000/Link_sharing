package helloworld


class RegisterController {
    def registerService

    def index() {
//        if(session.username!=null){
//            redirect(url :"/index")
//        }
        render(view:"index")
    }

    def updateProfile(){
        User user = User.findByUsername(session.username);
        session.username = params.username
        def flag = registerService.updateProfileUsingCredentials(params , user)
        if(flag) {
            flash.successMessage = "Profile updated Successfully"
            redirect(url : "/admin/editProfileView", model :['msg' : flash.successMessage ])
        }
        else {
            flash.successMessage = "Profile not updated Successfully"
            redirect(url : "/admin/editProfileView", model :['msg' : flash.successMessage ])
        }
    }

    def updatePassword(){

        println "---------->" + params
        User user = User.findByUsername(session.username);
        def flag = registerService.updatePasswordUsingCredentials(params , user)
        if(flag) {
            println "password updated 11"
            flash.successMessage = "Password updated Successfully"
            redirect(url : "/admin/editProfileView", model :['msg' : flash.successMessage ])
        }
        else {
            println "password updated13"
            flash.successMessage = "Password and confirm password not matching"
            redirect(url : "/admin/editProfileView", model :['msg' : flash.successMessage ])
        }

    }

    def deactivateUser(){
        print "deactivate User" + params

        User user = User.get(Integer.parseInt(params.userId))
        println "user found"
        if (user) {
            user.active = false
            user.save(flush:true , failOnError:true)
            render(status: 200, text: 'user deactivated')
        } else {
            render(status: 404, text: 'user not deactivated')
        }
    }

    def activateUser(){

        print "activateUser" + params
        User user = User.get(Integer.parseInt(params.userId))
        if (user) {
            user.active = true
            user.save(flush:true , failOnError:true)
            render(status: 200, text: 'user activated')
        } else {
            render(status: 404, text: 'user not activated')
        }
    }

}
