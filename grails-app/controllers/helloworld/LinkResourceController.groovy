package helloworld

class LinkResourceController {

    def linkResourceService
    def index() {

    }

    def saveLinkResource(){
        User user = User.findByUsername(session.username)
       // render params
        boolean flag = linkResourceService.saveLinkUsingCredentials(params , user)

        if(flag){
            render("Your Link resource is saved successfully")
//            redirect(url :"/dashboard")
        }
        else{
            render("Some Error has been occurred")
        }
    }
}
