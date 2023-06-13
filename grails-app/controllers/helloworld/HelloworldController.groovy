package helloworld

class HelloworldController {

    def index() {
        if(session.username==null){
            redirect(url :"/index")
            return
        }
        if(session.username!=null){
            redirect(url :"/dashboard")
            return
        }
    }
}
