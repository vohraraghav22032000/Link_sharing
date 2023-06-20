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
        boolean flag = documentResourceService.saveDocumentUsingCredentials(params , user)
        if(flag){
            flash.successMessage = "Documents Resources are saved successfully"
            redirect(url : "/dashboard", model :['msg' : flash.successMessage ])
        }
        else{
            flash.errorMessage = "Please enter valid file and description"
            redirect(url : "/dashboard", model :['msg' : flash.errorMessage ])
        }
    }

    def deletePost(){
        def resource = Resource.get(params.resourceId)
        if (resource) {
            resource.delete(flush: true)
            render(status: 200, text: 'Resource deleted')
        } else {
            render(status: 404, text: 'Resource not found')
        }
    }
}
