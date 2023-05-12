package helloworld

import grails.boot.GrailsApp
import grails.boot.config.GrailsAutoConfiguration

class Application extends GrailsAutoConfiguration {
    static void main(String[] args) {
        GrailsApp.run(Application, args)
        dataSource{
            pooled=true
            jmxExport=true
            driverClassName="oracle.jdbc.OracleDriver"
            dialect="org.hibernate.dialect.Oracle10gDialect"
            username="linksharing"
            password="linksharing"
        }

        environments{
            development{
                dataSource {
                    dbCreate="create-drop"
                    url="jdbc:oracle:thin:@localhost:1521/orcl"
                }}}
    }
}