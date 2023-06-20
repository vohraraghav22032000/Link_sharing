package helloworld

class DashboardService {

    Map createTopicMap(List allTopics){
        Map topicMap = [:]
        allTopics.each { Topic topic ->
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
