package helloworld

import Enum.Seriousness

class Subscription {

    def subscriptionService

    Topic topic
    User user
    Date dateCreated;
    Seriousness seriousness

    static belongsTo = [user : User , topic : Topic]

    static constraints = {
    }
}
