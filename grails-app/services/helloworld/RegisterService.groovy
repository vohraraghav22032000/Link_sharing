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
import grails.core.support.GrailsApplicationAware
import grails.core.GrailsApplication
import grails.web.mapping.LinkGenerator


@Transactional
class RegisterService {
    MailSender mailSender
    LinkGenerator grailsLinkGenerator

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
        try{
            def multipartFile = params.photo
            def photoExtension = multipartFile.getOriginalFilename().tokenize('.')[-1]
            def bytes = multipartFile.getBytes()
            def url = "grails-app/assets/images/profilePicture/${params.username}.${photoExtension}"
            def newFile = new File("${url}")
            newFile.createNewFile()
            newFile.append(bytes)
            params.photo  = url
            u.photo = params.photo
        }

        catch(Exception e){
            println e
            u.photo = "grails-app/assets/images/defaultImage.png"
        }
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
        currUser.firstname = params.firstname
        currUser.lastname = params.lastname
        currUser.username = params.username
        if(params.photo instanceof MultipartFile && !params.photo.isEmpty()){
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
        else{
            currUser.save(flush:true , failOnError:true)
            return true
        }

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
        try{
            String subject = "Regarding your new password"

            def msg = new SimpleMailMessage();
            msg.setFrom("vohraraghav@outlook.com")

            def resetPasswordUrl = "http://localhost:9090/index/resetPasswordUsingLink"

            String mailText = "Click the following link to reset your password: ${resetPasswordUrl}"
            msg.setTo(params.userEmail)
            msg.setSubject(subject)
            msg.setText(mailText)
            mailSender.send(msg)

            return true
        }
        catch(Exception e){
            println e
            return false
        }
    }

}
