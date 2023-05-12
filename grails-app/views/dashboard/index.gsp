<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css" integrity="sha384-b6lVK+yci+bfDmaY1u0zE8YYJt0TZxLEAFyYSLHId4xoVvsrQu3INevFKo+Xir8e" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'dashBoard.css')}">


</head>
    <body>
        <g:render template="/layouts/navbar" model="[subscriptionList : subscriptionList , isAdmin : isAdmin]"/>

        <main>
            <div class="sidebar-left">
                <div class="profile">
                    <h2>Your Profile</h2>
                    <div class="container">
                        <div class="row">
                            <div class="col-md-4">
                                <img src="${resource(dir: 'images', file: 'defaultImage.png')}" alt="Example Image">
                            </div>
                            <div class="col-md-8">
                                <h4>${user.firstname} ${user.lastname}</h4>
                                <p><strong>Subscriptions:</strong>${subscriptionList.size()}</p>
                                <p><strong>Topics:</strong>${topicCount}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="subscriptions">
                    <h2>Your Subscriptions</h2>
                    <g:render template="/layouts/subscriptions" model="[subscriptionList : subscriptionList]"/>
%{--                    <div class="post">--}%
%{--                        <h3>Example post title</h3>--}%
%{--                        <p>Example post content</p>--}%
%{--                    </div>--}%
                </div>
                <div>
                    <div class="trending-topics">
                        <ul>
                            <g:each in="${posts}" var="item">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <img src="${resource(dir: 'images', file: 'defaultImage.png')}" alt="Example Image">
                                            %{--                                <g:img dir="images" file="${item.createdBy.photo}" alt="User Image" class="img-fluid"/>--}%
                                        </div>
                                        <div class="col-md-6">
                                            <h2 class="user-name">${item.createdBy.firstname} ${item.createdBy.lastname} created ${item.name}</h2>
                                            <p class="user-description">John Doe is a software engineer who loves to code and build new things.</p>
                                        </div>
                                    </div>
                                </div>
                            </g:each>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="sidebar-right">
                 <div class="inbox">
                     <h2>Inbox</h2>
                </div>
            </div>
%{--            <div>--}%
%{--                <div class = "inbox">--}%
%{--                    <h2>Your recent Topic</h2>--}%
%{--                </div>--}%
%{--            </div>--}%
        </main>
    <script src = "/home/raghavvohra/helloworld/grails-app/assets/javascripts/navbarTemplate.js"
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    </body>
</html>

