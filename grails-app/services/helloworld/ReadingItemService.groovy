package helloworld

import grails.gorm.transactions.Transactional

@Transactional
class ReadingItemService {

    def serviceMethod() {

    }

    List readingItemOfUser(User currUser){
        return ReadingItem.createCriteria().list() {
            eq("isRead", false)
            eq("user", currUser)
        }
    }
}
