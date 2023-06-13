package helloworld

import Enum.Visibility
import grails.gorm.transactions.Transactional

@Transactional
class SearchService {

    def searchWithParams(String search) {
        println "search in search function---------> $search"
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

    def searchWithParamsPostView(String search,User user) {
        println "search in search function---------> $search"
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

    def searchWithParamsTopicView(String search,User user) {
        println "search in params topic view function---------> $search"
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

    def searchRecentListWithoutLogin(String search){
        def topPost = Resource.createCriteria().list(){
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

        println "%%%top posts without search" + topPost
        return topPost
    }
}
