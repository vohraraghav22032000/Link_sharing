package helloworld

class Resource {

    String description;
    Date dateCreated;
    Date lastUpdated;
    User createdBy;
    Topic topic;

    static belongsTo = [createdBy : User , topic : Topic]

    static hasMany = [readingItems : ReadingItem , resourceRatings : ResourceRating]

    static constraints = {
    }
    static mapping = {
        table "localResource"

    }
}
