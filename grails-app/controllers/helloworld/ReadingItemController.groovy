package helloworld

import Enum.Seriousness

class ReadingItemController {

    def index() {
        if(session.username == null){
            redirect(url :"/")
            return
        }
    }

    def resourceReaded(){
        def readingItem = ReadingItem.get(params.readingItemId)
        if (readingItem) {
            readingItem.isRead = true
            readingItem.save(flush:true)
            render(status: 200, text: 'Mark readed')
        } else {
            render(status: 404, text: 'not readed')
        }
    }
}
