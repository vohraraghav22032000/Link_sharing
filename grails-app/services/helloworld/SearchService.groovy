package helloworld

import Enum.Visibility
import grails.gorm.transactions.Transactional

@Transactional
class SearchService {

    List searchWithParams(String search) {
        if (search.trim() == '') {
            return ReadingItem.createCriteria().list(){}
        }
        else {
            return ReadingItem.createCriteria().list {
                resource {
                    or {
                        topic {
                            ilike('name', "%$search%")
                        }
                        ilike('description', "%$search%")
                    }
                }
            }
        }

    }

    List searchWithParamsPostView(String search,User user) {
        if (search.trim() == '') {
            return ReadingItem.createCriteria().list(){
                and{
                    eq("isRead",false)
                    eq("user" , user)
                }
            }
        }
        else {
            return ReadingItem.createCriteria().list {
                and{
                    eq("isRead",false)
                    eq("user" , user)
                }
                resource {
                    or {
                        topic {
                            ilike('name', "%$search%")
                        }
                        ilike('description', "%$search%")
                    }
                }
            }
        }

    }

    List searchWithParamsTopicView(String search,User user) {
        if (search.trim() == '') {
            return Topic.createCriteria().list(){
                eq("createdBy" , user)
            }
        }
        else {
            return Topic.createCriteria().list {
                println "search in params topic view function--------- in  else part> $search"
                and{
                    eq("createdBy" , user)
                    ilike('name', "%$search%")
                }
            }
        }

    }

    List searchRecentListWithoutLogin(String search){
        List topPost = Resource.createCriteria().list(){
            or {
                topic {
                    eq("visibility" , Visibility.PUBLIC)
                    ilike('name', "%$search%")
                }
                ilike('description', "%$search%")
            }
            order("lastUpdated","desc")
            maxResults 5
        }
        return topPost
    }

    List searchtopRatingPostWihoutLogin(String search){
        def topRatingPost = ResourceRating.createCriteria().list(){
            order("score","desc")
            resource{
                topic{
                    ilike('name', "%$search%")
                    eq("visibility", Visibility.PUBLIC)
                }
            }
            maxResults 5
        }
        return topRatingPost
    }
}
