<%--
  Created by IntelliJ IDEA.
  User: raghavvohra
  Date: 24/05/23
  Time: 3:24 pm
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Topic Show</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css" integrity="sha384-b6lVK+yci+bfDmaY1u0zE8YYJt0TZxLEAFyYSLHId4xoVvsrQu3INevFKo+Xir8e" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'homePage.css')}">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/dataTables.bootstrap5.min.js"></script>
</head>

    <body>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");
            response.setHeader ("Clear-Site-Data", "\"cache\"");
            response.setHeader("Cache-Control", "private, no-store, max-age=0, no-cache, must-revalidate");

            if(session==null)
                response.sendRedirect(url : "/authentication");
        %>

        <g:if test="${session.username}">
            <g:render template="/layouts/topicPostNavbar" model="[subscriptionList : subscriptionList , isAdmin : isAdmin , user : user]"/>
        </g:if>
        <g:else>
            <nav class="navbar navbar-expand-lg navbar-light bg-light justify-content-between">
                <g:link controller="Dashboard" action="index" class="navbar-brand" style="margin-left: 20px"><strong>Link Sharing</strong></g:link>
            </nav>
        </g:else>

        <main>
            <div class="sidebar-left">
                <div class="status-container">
                    <h2>Topic : ${topic.name}</h2>
                    <hr>
                    <div class="container">
                        <div class="row">
                            <div class="col-4">
                                <g:if test="${topic.createdBy.photo}">
                                    <g:img dir="images" file="${topic.createdBy.photo.substring(25)}" style="border: 2px solid black;border-radius: 10px" height="90px" width="90px"/>
                                 </g:if>
                                <g:else>
                                    <img src="${resource(dir: 'images', file: 'defaultImage.png')}" style="border: 2px solid black;border-radius: 10px" height="90px" width="90px" alt="Example Image">
                                </g:else>
                            </div>
                            <div class="col-8">
                                <h6>${topic.name}</h6>
                                <g:if test="${user}">
                                    <g:if test="${!topicCreatedByUserId.contains(topic.id)}">
                                        <g:if test="${topicMap.get(topic).topicCreatedBy.username!=session.username}">
                                            <g:if test="${subscriptionListId.contains(topic.id)}">
                                                <button id = "${topic.id}" class="unsubscribeBtn5 btn btn-dark">Unsubscribe</button>
                                            </g:if>
                                            <g:else>
                                                <button id = "${topic.id}" class="subscribeBtn5 btn btn-secondary">Subscribe</button>
                                            </g:else>
                                        </g:if>
                                    </g:if>
                                </g:if>

                                <g:if test="${session.username}">
                                    <g:link controller="Dashboard" action="allUsers" params="[userId : topic.createdBy.id]">
                                        <h6>${topic.createdBy.username}</h6>
                                    </g:link>
                                </g:if>

                                <div class="row">
                                    <div class="col-5">
                                        <p>Subscriptions :${topicMap.get(topic).subscribedCount}</p>
                                    </div>
                                    <div class="col-3">
                                        <p>Posts : ${topicMap.get(topic).postCount}</p>
                                    </div>
                                    <div class="col-4">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="status-container">
                    <h2>Users : ${topic.name}</h2>
                    <table class="table topicTable" width="100%">
                        <thead>
                        <tr>
                            <th class="th-sm">
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                    <g:each in="${allSubUser}" var="item">
                        <tr>
                            <td>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">
                                            <g:if test="${item.photo}">
                                                <g:link controller="Dashboard" action="allUsers" params="[userId : item.id]">
                                                    <g:img dir="images" file="${item.photo.substring(25)}" style="border: 2px solid black;border-radius: 10px" height="90px" width="90px"/>
                                                </g:link>
                                            </g:if>
                                            <g:else>
                                                <g:link controller="Dashboard" action="allUsers" params="[userId : item.id]">
                                                    <img src="${resource(dir: 'images', file: 'defaultImage.png')}" style="border: 2px solid black;border-radius: 10px"  height="90px" width="90px" alt="Example Image">
                                                </g:link>
                                            </g:else>
                                        </div>
                                        <div class="col-8">
                                            <h4>${item.firstname} ${item.lastname}</h4>
                                            <g:if test="${session.username}">
                                                <g:link controller="Dashboard" action="allUsers" params="[userId : item.id]">
                                                    <h4>${item.username}</h4>
                                                </g:link>
                                            </g:if>
                                            <div class="row">
                                                <div class="col-6">
                                                    <p>Subscriptions : ${allSubUserMap.get(item).subscribedCountOfUser}</p>
                                                </div>
                                                <div class="col-6">
                                                    <p>Topics : ${allSubUserMap.get(item).topicCountOfUser}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>

                    </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="sidebar-right">
                <div class="status-container">

                    <div class="row" style="margin-top: 10px">
                        <div class="col-7">
                            <h3 style="margin-left: 25px">Posts : ${topic.name}</h3>
                        </div>
                        <div class="col-5">
                            <g:form class="form-inline my-2 my-lg-0" style="display: flex;" controller="topicShow" params="[topicId: topic.id]">
                                <div class="input-group">
                                    <g:field name="search" style="width: 80px" type="search" placeholder="Search" class="form-control" id="" maxlength="128" title="please enter valid text" required="true"/>
                                    <div class="input-group-append">
                                        <g:submitButton name="Search" style="margin-left: 5px ;margin-right:5px" class="btn btn-outline-success" type="submit">Search</g:submitButton>
                                    </div>
                                </div>
                            </g:form>
                        </div>
                    </div>
                    <table class="table topicTable" width="100%">
                        <thead>
                        <tr>
                            <th class="th-sm">
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                    <g:each in="${topicPosts}" var="item">
                        <tr>
                            <td>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-3">
                                            <g:if test="${item.createdBy.photo}">
                                                <g:img dir="images" file="${item.createdBy.photo.substring(25)}" style="border: 2px solid black;border-radius: 10px" height="90px" width="90px"/>
                                            </g:if>
                                            <g:else>
                                                <img src="${resource(dir: 'images', file: 'defaultImage.png')}" style="border: 2px solid black;border-radius: 10px" height="90px" width="90px" alt="Example Image">
                                            </g:else>
                                        </div>
                                        <div class="col-9">
                                            <p>${item.description}</p>
                                            <div class="row">
                                                <div class="col-1">
                                                    <a href="https://www.facebook.com" target="_blank">
                                                        <i class="bi bi-facebook"></i>
                                                    </a>
                                                </div>
                                                <div class="col-1">
                                                    <a href="https://www.twitter.com" target="_blank">
                                                        <i class="bi bi-twitter"></i>
                                                    </a>
                                                </div>
                                                <div class="col-1">
                                                    <a href="https://www.google.com" target="_blank">
                                                        <i class="bi bi-google"></i>
                                                    </a>
                                                </div>
                                                <div class="col-4">
                                                    <g:if test="${item.class as String == 'class helloworld.LinkResource'}">
                                                    %{--                                                <p>${item.resource.url}</p>--}%
                                                        <a href="${item.url}" target="_blank" >
                                                            View Site
                                                            %{--                                View Site--}%
                                                        </a>
                                                    </g:if>
                                                    <g:else>
                                                        <a href="${item.filePath}" target="_blank" download>
                                                            Download
                                                        </a>
                                                    </g:else>
                                                </div>
                                                <div class="col-5">
                                                    <g:link value="${item.topic.name}" params="[topicId: item.topic.id , resourceId : item.id]" controller="postShow" action="index">
                                                        View Post
                                                    </g:link>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>

                    </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>

    <script src = "/home/raghavvohra/helloworld/grails-app/assets/javascripts/navbarTemplate.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

    <!-- Load jQuery and Bootstrap JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/dataTables.bootstrap5.min.js"></script>
        <script>
            $('.topicTable').DataTable({
                "lengthChange": false,
                "searching" : false
            });
            $('.markRead').click(function (){
                var readingItemId = this.id

                $.ajax({
                    url : "/readingItem/resourceReaded?readingItemId="+readingItemId,
                    success : function(response){
                        window.location.reload();
                        // alert("mark readed");
                    }
                });
            });
            $('.subscribeBtn5').click(function (event){
                console.log("raghav")
                var topicId = this.id
                console.log(topicId)
                $.ajax({
                    url : "/Subscription/addSubscription?topicId="+topicId, success : function(response){
                        window.location.reload();
                    }
                });
            });

            $('.unsubscribeBtn5').click(function (event){
                console.log("unsubscribed btn is clicked")

                var topicId = this.id
                console.log(topicId)
                $.ajax({
                    url : "/Subscription/deleteSubscription?topicId="+topicId, success : function(response){
                        window.location.reload();
                    }
                });
            });
        </script>
    </body>
</html>