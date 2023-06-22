package helloworld

class LinkResourceController {

    def linkResourceService
    def index() {
        if(session.username==null){
            redirect(url :"/authentication")
            return
        }
    }

    def saveLinkResource(){

        User user = User.findByUsername(session.username)
        boolean flag = linkResourceService.saveLinkUsingCredentials(params , user )

        if(flag){
            flash.successMessage = "Link resources are saved successfully"
            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
        else{
            flash.errorMessage = "Description cannot be greater than 128 characters"
            redirect(url : "/dashboard", model :['msg' : flash.errorMessage ])
        }
    }
}


