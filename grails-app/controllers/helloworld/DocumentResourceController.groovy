package helloworld

class DocumentResourceController {

    def documentResourceService

    def index() { }

    def saveDocumentResource(){
        User user = User.findByUsername(session.username)
//        render params
        boolean flag = documentResourceService.saveDocumentUsingCredentials(params , user)

        if(flag){
            render("Your Document resource is saved successfully")
//            redirect(url :"/dashboard")
        }
        else{
            render("Some Error has been occurred")
        }
    }
}
