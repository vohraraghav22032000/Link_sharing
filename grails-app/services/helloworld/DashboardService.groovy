package helloworld

class DashboardService {

    def createTopicMap(def allTopics){
        def topicMap = [:] // Initialize an empty map

        allTopics.each { topic ->
            def topicName = topic.name
            def topicCreatedBy = topic.createdBy
            def subscribedCount = topic.subscriptions.size()
            def postCount = topic.resources.size()
            def subscribedUser = topic.subscriptions
            topicMap[topic] = [subscribedCount: subscribedCount, postCount: postCount ,
                               topicName: topicName , topicCreatedBy : topicCreatedBy,
                               subscribedUser : subscribedUser]
        }

        return topicMap
    }
}
