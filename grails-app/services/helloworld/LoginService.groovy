package helloworld

import grails.gorm.transactions.Transactional

@Transactional
class LoginService {

    def checkUserExistence(String userEmail,String userUsername){
        User userOverEmail = User.findByEmailOrUsername(userEmail , userUsername)
        return userOverEmail

    }
}
