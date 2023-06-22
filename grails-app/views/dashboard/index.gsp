<!DOCTYPE html>
<html lang="en">
%{--<%@ page import="java.util.ArrayList" %>--}%
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css" integrity="sha384-b6lVK+yci+bfDmaY1u0zE8YYJt0TZxLEAFyYSLHId4xoVvsrQu3INevFKo+Xir8e" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'dashBoard.css')}">
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'flashMessage.css')}">

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

        <g:if test="${flash.successMessage}">

            <div id="success-message" class="alert alert-success toast show position-fixed top-0 start-50 translate-middle-x" style="z-index: 9999; background-color: darkgrey;">
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
                    <strong class="me-auto">${flash.errorMessage}</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
                </div>
            </div>
            </div>
        </g:if>

        <g:render template="/layouts/navbar" model="[user : user ,subscriptionList : subscriptionList , isAdmin : isAdmin , topicCreatedByUserList : topicCreatedByUserList ]"/>

            <main>
                <div class="sidebar-left">
                    <div class="profile">
                        <g:render template="/layouts/profile" model="[user : user ,subscriptionList : subscriptionList , isAdmin : isAdmin , subscribedCount : subscribedCount , topicCreatedByUserList: topicCreatedByUserList , topicMap : topicMap]"/>
                    </div>
                    <div class="subscriptions">
                    <div class="row">
                        <div class="col-md-7">
                            <h3>Your Subscription</h3>
                        </div>
                        <div class="col-md-5">
                            <button id="mybtn1" type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#allTopic" data-bs-whatever="@mdo"  style="margin-right: 5px; margin-left:5px" >View all Topics</button>

                            <div class="modal fade" id="allTopic" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="exampleModalLabel">View all Topics</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <g:render template="/layouts/allSubscriptions" model="[subscriptionList : subscriptionList ,subscriptionListId : subscriptionListId, topicCreatedByUserId: topicCreatedByUserId , isAdmin: isAdmin,allTopics : allTopics , user : user,topicMap: topicMap]"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <g:render template="/layouts/subscriptions" model="[subscriptionList : firstFiveSubscriptions ,subscriptionListId: subscriptionListId ,  user : user , topicCreatedByUserId: topicCreatedByUserId , isAdmin: isAdmin , topicMap: topicMap]"/>
                </div>

                <div>
                    <div class="trending-topics">
                        <h2>Trending Topics</h2>
                        <hr>
                        <g:each in="${trendingList}" var = "item">
                            <div class="container">
                                <div class="row">
                                    <div class="col-3">
                                        <g:if test="${item[0].createdBy.photo}">
                                            <g:link params="[userId: item[0].createdBy.id]" controller="Dashboard" action="allUsers">
                                                <g:img dir="images" file="${item[0].createdBy.photo.substring(25)}"  style="border: 2px solid black;border-radius: 10px" height="70px" width="70px"/>
                                            </g:link>
                                        </g:if>
                                        <g:else>
                                            <g:link params="[userId: item[0].createdBy.id]" controller="Dashboard" action="allUsers">
                                                <img src="${resource(dir: 'images', file: 'defaultImage.png')}"  style="border: 2px solid black;border-radius: 10px" width="70px" height="70px" alt="Example Image">
                                            </g:link>
                                        </g:else>
                                    </div>
                                    <div class="col-9">
                                        <div class="row">
                                            <div class="col-6">
                                                <g:link params="[topicId: item[0].id]" controller="topicShow" action="index">
                                                    <p>${item[0].name}</p>
                                                </g:link>
                                            </div>
                                            <div class = "col-6">
                                                <g:link controller="Dashboard" action="allUsers" params="[userId : item[0].createdBy.id]">
                                                   <p>${item[0].createdBy.username}</p>
                                                </g:link>
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
                                                <g:if test="${subscriptionListId.contains(item[0].id)}">
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
            </div>
            <div class="sidebar-right">
                 <div style="border: 2px solid black;border-radius : 10px">
                     <g:render template="/layouts/resources" model="[allResources : allResources]"/>
                </div>
            </div>
        </main>
    <script src = "/home/raghavvohra/helloworld/grails-app/assets/javascripts/navbarTemplate.js"
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

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

