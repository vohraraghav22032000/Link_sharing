package helloworld

class SubscriptionController {

    def subscriptionService;


    def index() {
        User user = User.findByUsername(session.username);
//        render "user found" + user
        def result = subscriptionService.topicSubscribedByUser(user)

        render result

    }
}
