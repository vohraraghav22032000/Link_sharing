package helloworld

class LinkResourceService {


    def saveLinkUsingCredentials(def params , User currUser){

        println 'params are' + params
        if(params.linkdes.length()>=128){
            return false
        }

        LinkResource linkResource = new LinkResource();
        linkResource.url = params.linkres
        linkResource.createdBy = currUser
        linkResource.description = params.linkdes
        Topic topic = Topic.findById(params.linkTopic)
        linkResource.topic = topic

        def allSubUser = topic.subscriptions*.user
        println "all********************" + allSubUser


        linkResource.validate()
        linkResource.save(flush : true , failOnError : true)
        try{
            allSubUser.each{it->
                ReadingItem readingItem = new ReadingItem()
                readingItem.user = it
                readingItem.resource = linkResource
                readingItem.isRead = false
                readingItem.validate()
                readingItem.save(flush:true , failOnError : true)
            }
            println "Reading item is saved successfully"
        }
        catch (Exception e){
            println "reading Item not saved" + e
        }
        return true
    }
}
