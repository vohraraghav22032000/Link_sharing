package helloworld

import grails.testing.web.interceptor.InterceptorUnitTest
import spock.lang.Specification

class IndexInterceptorSpec extends Specification implements InterceptorUnitTest<IndexInterceptor> {

    def setup() {
    }

    def cleanup() {

    }

    void "Test index interceptor matching"() {
        when:"A request matches the interceptor"
            withRequest(controller:"index")

        then:"The interceptor does match"
            interceptor.doesMatch()
    }
}
