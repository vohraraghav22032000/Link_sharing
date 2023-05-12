package helloworld

//
//import org.apache.commons.fileupload.FileItemFactory
//import org.apache.commons.fileupload.disk.DiskFileItemFactory
//import org.apache.commons.fileupload.servlet.ServletFileUpload
//import org.springframework.web.multipart.MultipartFile

import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.commons.CommonsMultipartResolver


import grails.gorm.transactions.Transactional

@Transactional
class RegisterService {


    // Handle file upload
//    def uploadFile(MultipartFile file) {
//        if (!file.empty) {
//    // Store the file in the file system or database
//    // and associate it with the user's account
//        }
//    }


    def registerUserUsingCredentials(def params){
        User u = new User();
        u.username = params.username
        u.email = params.email

        u.lastname = params.lastname
        u.firstname= params.firstname
        u.password = params.password

        println "---->"+params

        if(u.validate() && params.password == params.confirmpassword){
            u.save(flush : true , failOnError : true)
            return true
        }
        else{
            render false
        }

    }
}
