package helloworld

import org.apache.tomcat.util.http.fileupload.FileUploadBase

class DocumentResourceController {

    def documentResourceService

    def index() {
        if(session.username==null){
            redirect(url :"/index")
            return
        }
    }

    def saveDocumentResource(){
        User user = User.findByUsername(session.username)
//        render params
        boolean flag = documentResourceService.saveDocumentUsingCredentials(params , user)

        if(flag){
            //render("Your Topic is saved successfully")
            flash.successMessage = "Documents Resources are saved successfully"
            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
        else{
            flash.successMessage = "Please enter valid file and description"
            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
    }

    def deletePost(){
        print params
        def resource = Resource.get(params.resourceId)
        if (resource) {
            resource.delete(flush: true)
            render(status: 200, text: 'Resource deleted')
        } else {
            render(status: 404, text: 'Resource not found')
        }
    }
}
