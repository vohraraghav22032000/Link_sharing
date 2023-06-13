package helloworld

import grails.gorm.transactions.Transactional

@Transactional
class LoginService {

    def serviceMethod() {

    }

    def checkUserExistence(String userEmail,String userUsername){
        User userOverEmail = User.findByEmailOrUsername(userEmail , userUsername)
        return userOverEmail


//        User userOverName = User.findByUsername(userInput)
//        return userOverName
    }
}
