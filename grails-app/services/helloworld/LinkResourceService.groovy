package helloworld

class LinkResourceService {

    def saveLinkUsingCredentials(def params , User currUser){

//        println 'parms are' + params

        LinkResource linkres = new LinkResource();
        linkres.url = params.linkres
        linkres.createdBy = currUser
        linkres.description = params.linkdes
        linkres.topic = Topic.findByNameAndCreatedBy(params.linkTopic, currUser)

        linkres.validate()
        linkres.save(flush : true , failOnError : true)

    }
}
