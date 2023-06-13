package helloworld

//
//import org.apache.commons.fileupload.FileItemFactory
//import org.apache.commons.fileupload.disk.DiskFileItemFactory
//import org.apache.commons.fileupload.servlet.ServletFileUpload
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.commons.CommonsMultipartResolver

import grails.gorm.transactions.Transactional

import org.springframework.mail.MailSender
import org.springframework.mail.SimpleMailMessage
//import org.springframework.security.crypto.password.PasswordEncoder
//import org.springframework.security.crypto.password.RandomPasswordGenerator
import java.security.SecureRandom

@Transactional
class RegisterService {
    MailSender mailSender

    def registerUserUsingCredentials(def params , def countFlag){
        User u = new User();
        u.username = params.username
        u.email = params.email

        u.lastname = params.lastname
        u.firstname= params.firstname
        u.password = params.password

        if(params.firstname.length()>=30 || params.password!=params.confirmpassword
            || params.lastname.length()>=30 ){
            return false
        }
//        if(params.password.length()<8){
//            return false
//        }

        try{
            def multipartFile = params.photo
//            println "multipartFile" + multipartFile
            def photoExtension = multipartFile.getOriginalFilename().tokenize('.')[-1]
    //        def photoExtension = multipartFile.getOriginalFilename()

//            println "photoExtension" + photoExtension
            def bytes = multipartFile.getBytes()
//            println "bytes" +bytes
            def url = "grails-app/assets/images/profilePicture/${params.username}.${photoExtension}"
            def newFile = new File("${url}")
//            println url
//            println "newFile" + newFile

            newFile.createNewFile()
            newFile.append(bytes)
            params.photo  = url
            u.photo = params.photo
        }

        catch(Exception e){
            println e
            u.photo = "grails-app/assets/images/defaultImage.png"
        }

        println "---->"+params

        if(u.validate() && params.password == params.confirmpassword){
            if(countFlag==true){
                u.admin = true
            }
            u.save(flush : true , failOnError : true)
            return true
        }
        else{
            return false
        }
    }

    def updateProfileUsingCredentials(def params , User currUser){
//        println "PARAMS IN UODATE PROFILE " + params
        currUser.firstname = params.firstname
        currUser.lastname = params.lastname
        currUser.username = params.username

//        session.username = params.username
        try{
            def multipartFile = params.photo
            def photoExtension = multipartFile.getOriginalFilename().tokenize('.')[-1]

            def bytes = multipartFile.getBytes()

            def url = "grails-app/assets/images/profilePicture/${params.username}.${photoExtension}"
            def newFile = new File("${url}")

            newFile.createNewFile()
            newFile.append(bytes)
            params.photo  = url
            currUser.photo = params.photo
        }

        catch(Exception e){
            currUser.photo = "grails-app/assets/images/defaultImage.png"
        }

        currUser.save(flush:true , failOnError:true)
        return true
    }

    def updatePasswordUsingCredentials(def params , User currUser){
        if(params.password == params.confirmpassword){
            currUser.password  = params.password
            currUser.save(flush:true , failOnError:true)
            println "password updated"
            return true
        }
        return false

    }

    def resetPassword(def params, User user){
       println params
        if(params.newPassword == params.confnewPassword){
            user.password = params.newPassword
            user.save(flush:true , failOnError : true)
            return true
        }
        else{
            return false
        }

//        try{
//            String subject = "Reagrding reset your password"
//
//            String alphabet = (('A'..'N')+('P'..'Z')+('a'..'k')+('m'..'z')+('2'..'9')).join()
//            int n = 6
//
//            def newPassword = new Random().with {
//                (1..n).collect { alphabet[ nextInt( alphabet.length() ) ] }.join()
//            }
//
////            println "*******************new password generated is********" +  newPassword
//            user.password = newPassword
//            user.save()
//            def msg = new SimpleMailMessage();
//            msg.setFrom("vohraraghav@outlook.com")
//            String  mailtext = "Your new password is " + newPassword
//            msg.setTo(params.userEmail)
//            msg.setSubject(subject)
//            msg.setText(mailtext)
//            mailSender.send(msg)
//
//            return true
//        }
//        catch(Exception e){
//            println e
//            return false
//        }
//

    }

}
