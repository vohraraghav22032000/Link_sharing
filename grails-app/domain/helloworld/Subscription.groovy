package helloworld

import Enum.Seriousness

class Subscription {


    Topic topic
    User user
    Date dateCreated;
    Seriousness seriousness

    static belongsTo = [user : User , topic : Topic]

    static constraints = {
    }
}
