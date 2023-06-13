package helloworld

import Enum.Seriousness

class SubscriptionService {
    HashMap<String, Date> sortByDateAsValue(HashMap<String, Date> hm)
    {
        // Create a list from elements of HashMap
        List<Map.Entry<String, Date> > list =
                new LinkedList<Map.Entry<String, Date> >(hm.entrySet());

        // Sort the list
        Collections.sort(list, new Comparator<Map.Entry<String, Date> >() {
            public int compare(Map.Entry<String, Date> o1,
                               Map.Entry<String, Date> o2)
            {
                return (o1.getValue()).compareTo(o2.getValue());
            }
        });

        // put data from sorted list to hashmap
        HashMap<String, Date> temp = new LinkedHashMap<String, Date>();
        Collections.reverse(list)
        for (Map.Entry<String, Date> aa : list) {
            temp.put(aa.getKey(), aa.getValue());
        }
        return temp;
    }

    def topicSubscribedByUser(User currUser){
//        return Subscription.findAllByUser(currUser)

        List tempSubList = Subscription.createCriteria().list{
            eq("user",currUser)
        }
        Map sub_topic_map = [:]
        tempSubList.each{ sub->
            sub_topic_map.put(sub.topic.id, sub.id)
        }

        Map topicMapWithResourceLastUpdated = [:]
        tempSubList.each{ sub->
            def res = Resource.createCriteria().list{
                projections {
                    property("lastUpdated")
                }
                eq("topic", sub.topic)
                order("lastUpdated", "desc")
            }

            println "res ------------>" + res
            if(!res[0]){
                Date defaultDate = new Date()
                defaultDate.setMonth(1)
                topicMapWithResourceLastUpdated.put(sub.topic.id,defaultDate)
            }
            else{
                topicMapWithResourceLastUpdated.put(sub.topic.id,res[0])
            }
        }
        Map sortedTopics = sortByDateAsValue(topicMapWithResourceLastUpdated)

        List finalSubList = []
        sortedTopics.each{topicID,topicLastUpdated->
            finalSubList.add(sub_topic_map.get(topicID))
        }

        List subscriptionList = []
        finalSubList.each{ subID->
            def l = Subscription.findById(subID)
            subscriptionList.add(l)
        }

        return subscriptionList
    }

}
