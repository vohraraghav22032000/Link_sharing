package helloworld

import grails.gorm.transactions.Transactional

@Transactional
class LoginService {

    def serviceMethod() {

    }

    def checkUserExistence(String userInput){
        if(userInput.contains('@')){
            User userOverEmail = User.findByEmail(userInput)
            return userOverEmail
        }

        User userOverName = User.findByUsername(userInput)
        return userOverName
    }
}
