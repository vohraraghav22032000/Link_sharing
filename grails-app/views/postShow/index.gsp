<%--
  Created by IntelliJ IDEA.
  User: raghavvohra
  Date: 24/05/23
  Time: 3:25 pm
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post Show</title>
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
                    <div class="container">
                        <div class = "row">
                            <div class="col-3">
                                <g:if test="${resource.createdBy.photo}">
                                    <g:img dir="images" file="${resource.createdBy.photo.substring(25)}" style="border: 2px solid black;border-radius: 10px" height="120px" width="120px"/>
                                </g:if>
                                <g:else>
                                    <img src="${resource(dir: 'images', file: 'defaultImage.png')}" style="border: 2px solid black;border-radius: 10px" height="120px" width="120px" alt="Example Image">
                                </g:else>
                            </div>
                            <div class="col-5">
                                <h2>${resource.createdBy.firstname} ${resource.createdBy.lastname}</h2>
                                <g:if test="${session.username}">
                                    <g:link controller="Dashboard" action="allUsers" params="[userId : resource.createdBy.id]">
                                        <h2>${resource.createdBy.username}</h2>
                                    </g:link>
                                </g:if>
                            </div>
                            <div class="col-4">
                                <g:link params="[topicId: topic.id]" controller="topicShow" action="index">
                                    <h4>${topic.name}</h4>
                                </g:link>
                                <h6>${topic.dateCreated}</h6>
                            </div>
                        </div>

                        <g:if test="${user}">
                            <div class="row">
                                <div class="col-7">
                                    <h3>Rate this Post:</h3>
                                </div>
                                <div class="col-3">
                                    <div class="rating">
                                        <g:if test="${alreadyRatedScore}">
                                            <%
                                                def i=1
                                            %>
                                            <g:while test="${i <= alreadyRatedScore}">
                                                <i id="${i}" class="clickable bi bi-balloon-heart-fill"></i>
                                                <%i++%>
                                            </g:while>
                                            <g:while test="${i<6}">
                                                <i id="${i}" class="clickable bi bi-balloon-heart"></i>
                                                <%i++%>
                                            </g:while>
                                        </g:if>
                                        <g:else>
                                            <i id="1" class="clickable bi bi-balloon-heart"></i>
                                            <i id="2" class="clickable bi bi-balloon-heart"></i>
                                            <i id="3" class="clickable bi bi-balloon-heart"></i>
                                            <i id="4" class="clickable bi bi-balloon-heart"></i>
                                            <i id="5" class="clickable bi bi-balloon-heart"></i>
                                        </g:else>
                                    </div>
                                </div>
                                <div class="col-2">
                                    <g:if test="${numberOfUsersRatedResource.size() > 0}">
                                        <p>${averageScore} (${numberOfUsersRatedResource.size()})</p>
                                    </g:if>
                                </div>
                            </div>
                        </g:if>

                        <div class="row">
                            <p>${resource.description}</p>
                        </div>
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
                            <div class="col-3">
                                <g:if test="${(user && user.admin) || resource.createdBy.username == session.username}">
                                    <g:link id="deleteRes" controller="resourceRating" action="deleteResource" params="[ resourceId : resource.id]" >Delete</g:link>
                                </g:if>
                            </div>
                            <div class="col-3">
                                <g:if test="${(user && user.admin) || resource.createdBy.username == session.username}">
                                    <g:if test="${resource.class as String == 'class helloworld.LinkResource'}">
                                        <g:link data-bs-toggle="modal" data-bs-target="#edit" data-bs-whatever="@mdo">
                                            Edit
                                        </g:link>
                                        <div class="modal fade" id="edit" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h1 class="modal-title fs-5" id="exampleModalLabel">Update Link Resource</h1>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <g:form controller="resourceRating" action="updateLinkResource" params="[ resourceId : resource.id , topicId : topic.id]">
                                                            <div class="mb-3">
                                                                <label for="docpath" class="col-form-label">Link</label>
                                                                <input type="text" class="form-control-file" id="docpath" name="doclink" required="true">
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="docdes" class="col-form-label">Discription</label>
                                                                <textarea class="form-control" id="docdes" name = "docdes" rows="3" required="true"></textarea>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <g:submitButton name="Update" class="btn btn-primary">Update</g:submitButton>
                                                                <g:link controller="Dashboard" action="index" class="btn btn-primary">Cancel</g:link>
                                                            </div>
                                                        </g:form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </g:if>
                                    <g:else>
                                        <g:link data-bs-toggle="modal" data-bs-target="#edit2" data-bs-whatever="@mdo">
                                            Edit
                                        </g:link>

                                        <div class="modal fade" id="edit2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h1 class="modal-title fs-5" id="exampleModalLabel">Update Document Resource</h1>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <g:form controller="resourceRating" action="updateDocumentResource" params="[ resourceId : resource.id , topicId : topic.id]">
                                                            <div class="mb-3">
                                                                <label for="docpath" class="col-form-label">Document</label>
                                                                <input type="file" class="form-control-file" id="docpath" name="docpath" required="true">
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="docdes" class="col-form-label">Discription</label>
                                                                <textarea class="form-control" id="docdes" name = "docdes" rows="3" required="true"></textarea>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <g:submitButton name="Update" class="btn btn-primary">Update</g:submitButton>
                                                                <g:link controller="Dashboard" action="index" class="btn btn-primary">Cancel</g:link>
                                                            </div>
                                                        </g:form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </g:else>
                                </g:if>
                            </div>

                            <div class="col-3">
                                <g:if test="${resource.class as String == 'class helloworld.LinkResource'}">
                                    <a href="${resource.url}" target="_blank" >
                                        View Site
                                    </a>
                                </g:if>
                                <g:else>
                                    <a href="${resource.filePath}" target="_blank" download="${resource.filePath}">
                                          Download Post
                                    </a>
                                </g:else>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="sidebar-right">
                <div class="status-container">
                    <g:if test="${user}">
                        <div class="trending-topics">
                            <h2>Trending Topics</h2>
                            <g:each in="${trendingList}" var = "item">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-3">
                                            <g:if test="${item[0].createdBy.photo}">
                                                <g:img dir="images" file="${item[0].createdBy.photo.substring(25)}" style="border: 2px solid black;border-radius: 10px" height="70px" width="70px"/>
                                            </g:if>
                                            <g:else>
                                                <img src="${resource(dir: 'images', file: 'defaultImage.png')}" style="border: 2px solid black;border-radius: 10px" width="70px" height="70px" alt="Example Image">
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
                    </g:if>
                    <g:else>
                        <div>
                            <h4>Recent Shares</h4>
                            <g:each in ="${posts}" var = "item">
                                <div class="row" style="height: 90px">
                                    <div class="col-3">
                                        <g:if test="${item.createdBy.photo}">
                                            <g:img dir="images" file="${item.createdBy.photo.substring(25)}" style="border: 2px solid black;border-radius: 10px" margin-left= "20px" margin-right="20px" height="70px" width="70px"/>
                                        </g:if>
                                        <g:else>
                                            <img src="${resource(dir: 'images', file: 'defaultImage.png')}" style="border: 2px solid black;border-radius: 10px" margin-left= "20px" margin-right="20px" height="70px" width="70px"alt="Example Image">
                                        </g:else>
                                    </div>
                                    <div class="col-9">
                                        <div class="row">
                                            <div class="col-8">
                                                <div class="row">
                                                    <div class="col-4">
                                                        <h5>${item.createdBy.firstname}</h5>
                                                    </div>
                                                    <div class="col-4">
                                                        <h5>${item.createdBy.username}</h5>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-4">
                                                <g:link class = "topicName" value="${item.topic.name}" params="[topicId: item.topic.id, description : item.description]" controller="topicShow" action="index">${item.topic.name}</g:link>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-8">
                                                <p>${item.description}</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </g:each>
                        </div>

                    </g:else>
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
            $('.clickable').click(function (event){
                console.log("all star is clicked")
                console.log($(this).attr("id"));
                var j = parseInt($(this).attr("id"));
                console.log("resourceId is " + ${params.resourceId})
                console.log("value of j is" + j);
                for (var i = 1; i <= j; i++) {
                    $('#' + i).removeClass('bi-balloon-heart').addClass('bi-balloon-heart-fill');
                }
                $.ajax({
                    url : "/resourceRating/rateResource?score=" + $(this).attr("id") + "&resourceId=" + ${params.resourceId} ,
                    success : function(response){
                        console.log(response)
                        alert("Your rating saved successfully");
                        window.location.reload();
                    }
                });
            });
            $('.subscribeBtn').click(function (event){
                console.log("raghav")
                var topicId = this.id
                console.log(topicId)
                $.ajax({
                    url : "/Subscription/addSubscription?topicId="+topicId, success : function(response){
                        // window.location.reload();
                        alert("topic subscribed successfully");
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
                        // window.location.reload();
                        alert("topic unsubscribed successfully")
                        window.location.reload();
                    }
                });
            });
        });

    </script>
    </body>

</html>
