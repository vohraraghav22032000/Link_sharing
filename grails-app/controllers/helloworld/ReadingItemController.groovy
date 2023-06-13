package helloworld

import Enum.Seriousness

class ReadingItemController {

    def index() { }

    def resourceReaded(){
        println "params in resource Readed" + params.readingItemId
        def readingItem = ReadingItem.get(params.readingItemId)
        if (readingItem) {
            println "readingItem is marked true"
            readingItem.isRead = true
            readingItem.save(flush:true)
            render(status: 200, text: 'Mark readed')
        } else {
            render(status: 404, text: 'not readed')
        }
    }
}
