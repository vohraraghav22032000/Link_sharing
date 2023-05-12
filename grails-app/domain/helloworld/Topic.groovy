package helloworld

import Enum.Visibility

class Topic {

    String name;
    User createdBy;
    Date dateCreated;
    Date lastUpdated;
    Visibility visibility;

    static belongsTo = [createdBy : User]

    static hasMany = [subscriptions : Subscription,resources : Resource]

    static constraints = {
    }

    static mapping = {
        table "topic"
    }
}
