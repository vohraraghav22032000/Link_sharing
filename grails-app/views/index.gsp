%{--<!doctype html>--}%
%{--<html>--}%
%{--<head>--}%
%{--    <meta name="layout" content="main"/>--}%
%{--    <title>Welcome to Grails</title>--}%
%{--</head>--}%
%{--<body>--}%
%{--<content tag="nav">--}%
%{--    <li class="dropdown">--}%
%{--        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Application Status <span class="caret"></span></a>--}%
%{--        <ul class="dropdown-menu">--}%
%{--            <li class="dropdown-item"><a href="#">Environment: ${grails.util.Environment.current.name}</a></li>--}%
%{--            <li class="dropdown-item"><a href="#">App profile: ${grailsApplication.config.grails?.profile}</a></li>--}%
%{--            <li class="dropdown-item"><a href="#">App version:--}%
%{--                <g:meta name="info.app.version"/></a>--}%
%{--            </li>--}%
%{--            <li role="separator" class="dropdown-divider"></li>--}%
%{--            <li class="dropdown-item"><a href="#">Grails version:--}%
%{--                <g:meta name="info.app.grailsVersion"/></a>--}%
%{--            </li>--}%
%{--            <li class="dropdown-item"><a href="#">Groovy version: ${GroovySystem.getVersion()}</a></li>--}%
%{--            <li class="dropdown-item"><a href="#">JVM version: ${System.getProperty('java.version')}</a></li>--}%
%{--            <li role="separator" class="dropdown-divider"></li>--}%
%{--            <li class="dropdown-item"><a href="#">Reloading active: ${grails.util.Environment.reloadingAgentEnabled}</a></li>--}%
%{--        </ul>--}%
%{--    </li>--}%
%{--    <li class="dropdown">--}%
%{--        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Artefacts <span class="caret"></span></a>--}%
%{--        <ul class="dropdown-menu">--}%
%{--            <li class="dropdown-item"><a href="#">Controllers: ${grailsApplication.controllerClasses.size()}</a></li>--}%
%{--            <li class="dropdown-item"><a href="#">Domains: ${grailsApplication.domainClasses.size()}</a></li>--}%
%{--            <li class="dropdown-item"><a href="#">Services: ${grailsApplication.serviceClasses.size()}</a></li>--}%
%{--            <li class="dropdown-item"><a href="#">Tag Libraries: ${grailsApplication.tagLibClasses.size()}</a></li>--}%
%{--        </ul>--}%
%{--    </li>--}%
%{--    <li class="dropdown">--}%
%{--        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Installed Plugins <span class="caret"></span></a>--}%
%{--        <ul class="dropdown-menu">--}%
%{--            <g:each var="plugin" in="${applicationContext.getBean('pluginManager').allPlugins}">--}%
%{--                <li class="dropdown-item"><a href="#">${plugin.name} - ${plugin.version}</a></li>--}%
%{--            </g:each>--}%
%{--        </ul>--}%
%{--    </li>--}%
%{--</content>--}%

%{--<div class="svg" role="presentation">--}%
%{--    <div class="grails-logo-container">--}%
%{--        <asset:image src="grails-cupsonly-logo-white.svg" class="grails-logo"/>--}%
%{--    </div>--}%
%{--</div>--}%

%{--<div id="content" role="main">--}%
%{--    <section class="row colset-2-its">--}%
%{--        <h1>Welcome to Grails</h1>--}%

%{--        <p>--}%
%{--            Congratulations, you have successfully started your first Grails application! At the moment--}%
%{--            this is the default page, feel free to modify it to either redirect to a controller or display--}%
%{--            whatever content you may choose. Below is a list of controllers that are currently deployed in--}%
%{--            this application, click on each to execute its default action:--}%
%{--        </p>--}%

%{--        <div id="controllers" role="navigation">--}%
%{--            <h2>Available Controllers:</h2>--}%
%{--            <ul>--}%
%{--                <g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName } }">--}%
%{--                    <li class="controller">--}%
%{--                        <g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link>--}%
%{--                    </li>--}%
%{--                </g:each>--}%
%{--            </ul>--}%
%{--        </div>--}%
%{--    </section>--}%
%{--</div>--}%

%{--</body>--}%
%{--</html>--}%

%{--<!DOCTYPE html>--}%
%{--<html lang="en">--}%
%{--<head>--}%
%{--    <meta charset="UTF-8">--}%
%{--    <meta http-equiv="X-UA-Compatible" content="IE=edge">--}%
%{--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--}%
%{--    <title>Home Page</title>--}%
%{--    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'homePage.css')}">--}%
%{--</head>--}%
%{--<body>--}%
%{--<header>--}%
%{--    <h1>Link Sharing</h1>--}%
%{--    <div class="search-box">--}%
%{--        <input type="text" placeholder="Search...">--}%
%{--        <button>Search</button>--}%
%{--    </div>--}%
%{--</header>--}%
%{--<main>--}%
%{--    <div class="sidebar-left">--}%
%{--        <h2>Recent Shares</h2>--}%
%{--        <div class="status-container">--}%

%{--        </div>--}%
%{--        <h2>Top Posts</h2>--}%
%{--        <div class="top-posts">--}%
%{--            <div class="post">--}%
%{--                <h3>Example post title</h3>--}%
%{--                <p>Example post content</p>--}%
%{--            </div>--}%
%{--            <div class="post">--}%
%{--                <h3>Another example post title</h3>--}%
%{--                <p>Another example post content</p>--}%
%{--            </div>--}%
%{--        </div>--}%
%{--    </div>--}%
%{--    <div class="sidebar-right">--}%
%{--        <div class="login-form">--}%
%{--            <h2>Login</h2>--}%
%{--            <g:form controller="login" action="loginUser">--}%
%{--                <label for="email">Email/Username:</label>--}%
%{--                <input type="text" id="email" name="email">--}%
%{--                <label for="password">Password:</label>--}%
%{--                <input type="password" id="password" name="password">--}%
%{--                <div class="form-links">--}%
%{--                    <a href="#">Forgot password?</a>--}%
%{--                    <input type="submit" value="Login">--}%
%{--                </div>--}%
%{--            </g:form>--}%
%{--        </div>--}%
%{--        <div class="register-form">--}%
%{--            <h2>Register</h2>--}%
%{--               <g:form controller="register" action="registerUser">--}%
%{--                <label for="firstname">First Name:</label>--}%
%{--                <input type="text" id="firstname" name="firstname">--}%
%{--                <label for="lastname">Last Name:</label>--}%
%{--                <input type="text" id="lastname" name="lastname">--}%
%{--                <label for="email">Email:</label>--}%
%{--                <input type="email" id="email" name="email">--}%
%{--                <label for="username">Username:</label>--}%
%{--                <input type="text" id="username" name="username">--}%
%{--                <label for="password">Password:</label>--}%
%{--                <input type="password" id="password" name="password">--}%
%{--                <label for="confirmpassword">Confirm Password:</label>--}%
%{--                <input type="password" id="confirmpassword" name="confirmpassword">--}%
%{--                <label for="photo">Photo:</label>--}%
%{--                <input type="file" id="photo" name="photo">--}%
%{--                <input type="submit" value="Register">--}%
%{--              </g:form>--}%
%{--        </div>--}%
%{--    </div>--}%
%{--</main>--}%
%{--</body>--}%
%{--</html>--}%