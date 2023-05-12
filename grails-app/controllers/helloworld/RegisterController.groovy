package helloworld


class RegisterController {
    def registerService

    def index() {
        render(view:"index")
    }

    def registerUser(){
        //render params
        def flag = registerService.registerUserUsingCredentials(params)
        if(flag){
            redirect(url:"/index")
        }
        else{
            render "Some error has been occured"
        }
    }
}
