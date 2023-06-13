package helloworld

class LinkResourceController {

    def linkResourceService
    def index() {
        if(session.username==null){
            redirect(url :"/index")
            return
        }
    }

    def saveLinkResource(){

        User user = User.findByUsername(session.username)
       // render params

        boolean flag = linkResourceService.saveLinkUsingCredentials(params , user )

        if(flag){
            //render("Your Topic is saved successfully")
            flash.successMessage = "Link resources are saved successfully"
            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
        else{
            flash.successMessage = "Description cannot be greater than 128 characters"
            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
    }
}


