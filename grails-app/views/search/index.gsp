<%--
  Created by IntelliJ IDEA.
  User: raghavvohra
  Date: 24/05/23
  Time: 4:55 pm
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css" integrity="sha384-b6lVK+yci+bfDmaY1u0zE8YYJt0TZxLEAFyYSLHId4xoVvsrQu3INevFKo+Xir8e" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'homePage.css')}">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/dataTables.bootstrap5.min.js"></script>


    <style>
    #success-message {
        z-index: 9999;
        position: fixed;
        top: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 300px;
        background-color: darkgrey;
        color: white;
        padding: 10px;
        border-radius: 5px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
    }

    .toast-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 5px 10px;
    }

    .btn-close {
        color: white;
        opacity: 0.5;
    }

    .btn-close:hover {
        opacity: 1;
    }
    #error-message {
        z-index: 9999;
        position: fixed;
        top: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 300px;
        background-color: red !important;
        color: black;
        padding: 10px;
        border-radius: 5px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
    }


    </style>

</head>

<body>

    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        response.setHeader ("Clear-Site-Data", "\"cache\"");
        response.setHeader("Cache-Control", "private, no-store, max-age=0, no-cache, must-revalidate");

        if(session==null)
            response.sendRedirect(url : "/index");
    %>

    <g:if test="${flash.successMessage}">

        <div id="success-message" class="toast show position-fixed top-0 start-50 translate-middle-x" style="z-index: 9999; background-color: darkgrey;">
            <div class="toast-header" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="false">
                <strong class="me-auto">${flash.successMessage}</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
            </div>
        </div>
        </div>

    </g:if>
    <g:if test="${flash.errorMessage}">

        <div id="error-message" class="toast show position-fixed top-0 start-50 translate-middle-x" style="z-index: 9999; background-color: darkgrey;">
            <div class="toast-header" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="false">
                <strong class="me-auto">${flash.errorMessage}this is error message</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
            </div>
        </div>
        </div>
    </g:if>

<g:render template="/layouts/topicPostNavbar" model="[user : user ,subscriptionList : subscriptionList , isAdmin : isAdmin , topicCreatedByUserList : topicCreatedByUserList ]"/>

<main>
    <div class="sidebar-left">
        <div>
            <div class="trending-topics"  style="border: 2px solid black;border-radius : 10px">
                <h2 style="margin-left: 10px">Trending Topics</h2>
                <hr>
                <g:each in="${trendingList}" var = "item">
                    <div class="container">
                        <div class="row">
                            <div class="col-3">
                                <g:if test="${item[0].createdBy.photo}">
                                    <g:img dir="images" file="${item[0].createdBy.photo.substring(25)}" style="border: 2px solid black;border-radius : 10px" height="70px" width="70px"/>
                                </g:if>
                                <g:else>
                                    <img src="${resource(dir: 'images', file: 'defaultImage.png')}"  style="border: 2px solid black;border-radius : 10px" width="70px" height="70px" alt="Example Image">
                                </g:else>
                            </div>
                            <div class="col-9">
                                <div class="row">
                                    <div class="col-6">
                                        <p>${item[0].name}</p>
                                    </div>
                                    <div class = "col-6">
                                        <p>${item[0].createdBy.username}</p>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-6">
                                        <p>Subscriptions : ${topicMap.get(item[0]).subscribedCount}</p>
                                    </div>
                                    <div class = "col-6">
                                        <p>Posts : ${topicMap.get(item[0]).postCount}</p>
                                    </div>
                                </div>
                                <div>
                                    <g:if test="${topicMap.get(item[0]).topicCreatedBy.username!=session.username}">
                                        <g:if test="${subscriptionListName.contains(item[0].name)}">
                                            <button id = "${item[0].id}" class="unsubscribeBtn btn btn-dark">Unsubscribe</button>
                                        </g:if>

                                        <g:else>
                                            <button id = "${item[0].id}" class="subscribeBtn btn btn-secondary">Subscribe</button>
                                        </g:else>
                                    </g:if>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr>
                </g:each>
            </div>
        </div>
        <div style="border: 2px solid black;border-radius: 8px;margin-top: 10px">
            <h2 style="margin-left: 10px">Top Posts</h2>
            <hr>
            <g:each in ="${topRatingPost}" var = "item">
                <div class="row" style="height: 90px">
                    <div class="col-3">
                        <g:if test="${item.user.photo}">
                            <g:img dir="images" file="${item.user.photo.substring(25)}" style="border: 2px solid black;border-radius : 10px;margin-left: 10px;" height="70px" width="70px"/>
                        </g:if>
                        <g:else>
                            <img src="${resource(dir: 'images', file: 'defaultImage.png')}"  style="margin-left:10px;border: 2px solid black;border-radius : 10px" width="70px" height="70px" alt="Example Image">
                        </g:else>
                    </div>
                    <div class="col-9">
                        <div class="row">
                            <div class="col-8">
                                <p>${item.user.firstname} ${item.user.lastname} ${item.user.username} </p>
                            </div>
                            <div class="col-4">
                                <g:link class = "topicName" value="${item.resource.topic.name}" params="[topicId: item.resource.topic.id]" controller="topicShow" action="index">${item.resource.topic.name}</g:link>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-8">
                                <p>${item.resource.description}</p>
                            </div>
                            <div class="col-4">
                                <g:link class = "topicName2" value="${item.resource.topic.name}" params="[topicId: item.resource.topic.id , resourceId: item.resource.id]" controller="postShow" action="index">View Post</g:link>
                            </div>
                        </div>
                    </div>
                </div>
                <hr>
            </g:each>
        </div>
    </div>
    <div class="sidebar-right">
        <div style="border: 2px solid black;border-radius : 10px">
            <g:render template="/layouts/resources" model="[allResources : searchOutput]"/>
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
    $(document).ready(function() {
        $('.subscribeBtn').click(function (event){
            console.log("raghav")
            var topicId = this.id
            console.log(topicId)
            $.ajax({
                url : "/Subscription/addSubscription?topicId="+topicId, success : function(response){
                    window.location.reload();
                }
            });
        });

        $('.unsubscribeBtn').click(function (event){
            console.log("unsubscribed btn is clicked")

            var topicId = this.id
            console.log(topicId)
            $.ajax({
                url : "/Subscription/deleteSubscription?topicId="+topicId, success : function(response){
                    window.location.reload();
                }
            });
        });
    });
</script>
</body>
</html>