package helloworld

class RegisterController {
    def registerService

    def index() {
        if(session.username == null){
            redirect(url :"/")
            return
        }
    }

    def updateProfile(){
        User user = User.findByUsername(session.username);
        User checkUser = User.findByUsername(params.username);
        if(checkUser){
            flash.errorMessage = "This username already exists"
            redirect(url : "/admin/editProfileView", model :['msg' : flash.errorMessage ])
        }
        else{
            session.username = params.username
            def flag = registerService.updateProfileUsingCredentials(params , user)
            if(flag) {
                flash.successMessage = "Profile updated Successfully"
                redirect(url : "/admin/editProfileView", model :['msg' : flash.successMessage ])
            }
            else {
                flash.errorMessage = "Profile not updated Successfully"
                redirect(url : "/admin/editProfileView", model :['msg' : flash.errorMessage ])
            }
        }
    }

    def updatePassword(){

        User user = User.findByUsername(session.username);
        def flag = registerService.updatePasswordUsingCredentials(params , user)
        if(flag) {
            flash.successMessage = "Password updated Successfully"
            redirect(url : "/admin/editProfileView", model :['msg' : flash.successMessage ])
        }
        else {
            flash.errorMessage = "Password and confirm password not matching"
            redirect(url : "/admin/editProfileView", model :['msg' : flash.errorMessage ])
        }

    }

    def deactivateUser(){

        User user = User.get(Integer.parseInt(params.userId))

        if (user) {
            user.active = false
            user.save(flush:true , failOnError:true)
            render(status: 200, text: 'user deactivated')
        } else {
            render(status: 404, text: 'user not deactivated')
        }
    }

    def activateUser(){

        User user = User.get(Integer.parseInt(params.userId))
        if (user) {
            user.active = true
            user.save(flush:true , failOnError:true)
            render(status: 200, text: 'user activated')
        } else {
            render(status: 404, text: 'user not activated')
        }
    }

    def updatePasswordUsingLink(){
        User user = User.findByEmail(params.email)
        if(!user){
            flash.errorMessage = "Please enter valid email"
            redirect(url : "/index/resetPasswordUsingLink", model :['msg' : flash.errorMessage ])
        }
        else if(params.password != params.confirmpassword){
            flash.errorMessage = "Password and confirm password not matching"
            redirect(url : "/index/resetPasswordUsingLink", model :['msg' : flash.errorMessage ])
        }
        else{
            user.password  = params.password
            user.save(flush:true , failOnError:true)
            flash.successMessage = "Your password updated successfully , You can close this page"
            redirect(url : "/index/resetPasswordUsingLink", model :['msg' : flash.successMessage ])
        }
    }

}
