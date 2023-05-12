package helloworld

class User {

    String email;
    String username;
    String password;
    String firstname;
    String lastname;

    String photo ;
    Boolean admin = false;
    Boolean active = true;
    Date dateCreated;
    Date lastUpdated;

    static hasMany=[topics:Topic , subscriptions : Subscription ,
                    resources : Resource , resourceRatings : ResourceRating , readingItems : ReadingItem]

    /*User(String email,String username,String password,String firstName,String lastName,byte photo,boolean admin,boolean active,Date dateCreated,Date lastUpdated){
        this.email = email
        this.username = username
        this.password = password
        this.firstName = firstName
        this.lastName = lastName
        this.photo = photo
        this.admin = admin
        this.active = active
        this.dateCreated = dateCreated
        this.lastUpdated = lastUpdated
    }*/

    static constraints = {
        email unique: true
        username unique: true
        password blank : false
        lastname nullable : true
        photo nullable: true
        firstname nullable : false
    }
    static mapping = {
        table "localUser"
    }
}
