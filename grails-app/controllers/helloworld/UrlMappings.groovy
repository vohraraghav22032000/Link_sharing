package helloworld

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: 'index', action: 'index')
        "500"(view:'/error')
        "404"(view:'/notFound')
//        "404"(controller: 'index',action: 'notFound')
    }
}

//create USER linksharing30 IDENTIFIED BY linksharing30 DEFAULT TABLESPACE USERS QUOTA 250M ON USERS;
//GRANT CONNECT, CREATE TABLE, CREATE SESSION, RESOURCE, DBA TO linksharing30;