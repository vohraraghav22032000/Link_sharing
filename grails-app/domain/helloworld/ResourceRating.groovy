package helloworld

class ResourceRating {
    Resource resource
    User user;
    Integer score;
    Date dateCreated

    static belongsTo = [user : User , resource : Resource]

    static constraints = {
        score min:1 , max: 5
    }
}

