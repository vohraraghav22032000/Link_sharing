package helloworld

import Enum.Visibility

import java.util.Calendar
import grails.gorm.transactions.Transactional
import org.hibernate.criterion.Restrictions

class LoginController {

    def index(){
        if(session.username==null){
            redirect(url :"/authentication")
            return
        }
    }

    def logoutUser(){
        session.invalidate()
        redirect(url:"/")
    }
}
