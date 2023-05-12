package helloworld

class DocumentResourceService {

    def saveDocumentUsingCredentials(def params , User currUser){

//        println 'parms are' + params

        DocumentResource docres = new DocumentResource();
        docres.filePath = params.docpath
        docres.createdBy = currUser
        docres.description = params.docdes
        docres.topic = Topic.findByNameAndCreatedBy(params.docTopic, currUser)

        docres.validate()
        docres.save(flush : true , failOnError : true)

    }
}
