<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css" integrity="sha384-b6lVK+yci+bfDmaY1u0zE8YYJt0TZxLEAFyYSLHId4xoVvsrQu3INevFKo+Xir8e" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'homePage.css')}">
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'dashBoard.css')}">


    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'flashMessage.css')}">
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
                <strong class="me-auto">${flash.errorMessage}</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
            </div>
        </div>
        </div>
    </g:if>

    <g:render template="/layouts/profileNavbar" model="[isAdmin : isAdmin]"/>

        <main>
            <div class="sidebar-left">
                <div class="profile">
                    <g:render template="/layouts/profile" model="[subscriptionList : subscriptionList , isAdmin : isAdmin , topicCount : topicCount , user : user, subscribedCount : subscribedCount,topicCreatedByUserList : topicsCreatedByUserList , topicMap : topicMap]"/>
                </div>
                <div class="subscriptions">

                    <table  class="userTable table table-striped" width="100%">
                        <thead>
                        <h2 style="margin-left: 10px">Topics</h2>
                        <tr>
                            <th class="th-sm">
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                    <g:each in="${topicsCreatedByUserList}" var="item" >
                        <tr>
                        <td>
                        <div class="container">
                            <div class="row">
                                <div class="col-md-4">
                                    <div>

                                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal2" data-bs-whatever="@mdo" style="margin-right: 20px; margin-left:20px"><i class="bi bi-chat-right-dots"></i></button>

                                        <div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h1 class="modal-title fs-5" id="exampleModalLabel2">Enter details for sending invitation</h1>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <g:form controller="Topic" action="sendInvitation">
                                                            <div class="mb-3">
                                                                <label for="userEmail" class="col-form-label">Enter Email</label>
                                                                <g:field name="userEmail" type="email" class="form-control" id="userEmail" />
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="linkTopic" class="col-form-label">Choose topic</label>
                                                                <select name="linkTopic" id="linkTopic" class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" required="true">
                                                                    <option value="" selected disabled>Topic</option>
                                                                    <g:each in="${subscriptionList}" var="curr">
                                                                        <option value="${curr.topic.name}">${curr.topic.name}</option>
                                                                    </g:each>

                                                                </select>
                                                            </div>

                                                            <div class="modal-footer">
                                                                <g:submitButton name="Invite" class="btn btn-primary">Invite</g:submitButton>
                                                                <g:link controller="Dashboard" action="index" class="btn btn-primary">Cancel</g:link>

                                                            </div>
                                                        </g:form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <g:link controller="topicShow" action="index" params="[topicId : item.id]">
                                        <p>${item.name}</p>
                                    </g:link>
                                </div>
                            </div>
                            <div class="row" >
                                <div class="col-4" >
                                    <p>Subscriptions: ${topicMap.get(item).subscribedCount}</p>
                                </div>
                                <div class="col-4">
                                    <p>Posts : ${topicMap.get(item).postCount}</p>
                                </div>
                                <div class="col-4">
                                    <g:select name="${item.id}" id="${item.id}" class="updateVisibility" from="${['PUBLIC','PRIVATE'] -
                                            ["${item.visibility}"]}" value="${item.visibility}"
                                              noSelection="${['':item.visibility]}" />
                                </div>
                            </div>
                        </div>
                        </td>
                        </tr>
                    </g:each>
                        </tbody>
                    </table>

                </div>
                <div class="subscriptions">
                    <div>
                        <h2>Subscriptions</h2>
                        <hr>
                        <g:render template="/layouts/subscriptions" model="[subscriptionList : subscriptionList ,subscriptionListId: subscriptionListId ,  user : user , topicCreatedByUserId: topicCreatedByUserId , isAdmin: isAdmin , topicMap: topicMap]"/>
                    </div>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="sidebar-right">
                <div  style="border: 2px solid black;border-radius: 8px">
                    <table  class="userTable table table-striped" width="100%">
                        <thead>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-3">
                                <h3 style="margin-left: 25px">Posts</h3>
                            </div>
                            <div class="col-9">
                                <g:form class="form-inline my-2 my-lg-0" style="display: flex;" controller="admin" action="profileView">
                                    <div class="input-group">
                                        <g:field name="search" style="width: 100px" type="search" placeholder="Search" class="form-control" id="" required="true" />
                                        <div class="input-group-append">
                                            <g:submitButton name="Search" style="margin-left: 20px ;margin-right:20px" class="btn btn-outline-success" type="submit">Search</g:submitButton>
                                        </div>
                                    </div>
                                </g:form>
                            </div>
                        </div>

                        <tr>
                            <th class="th-sm">
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                    <g:each in="${allResourcesByUser}" var="item">
                        <tr>
                            <td>
                                <g:link controller="topicShow" action="index" params="[topicId : item.resource.topic.id]">
                                    <h6 style="margin-left: 15px">${item.resource.topic.name}</h6>
                                </g:link>

                                <p style="margin-left: 15px">${item.resource.description}</p>
                                <div class="row" style="margin-left: 15px">
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
                                        <g:if test="${item.resource.class as String == 'class helloworld.LinkResource'}">
                                            <a href="${item.resource.url}" target="_blank" >
                                                <button class="btnread">Visit</button>
                                            </a>
                                        </g:if>
                                        <g:else>
                                            <a href="" target="_blank" download="${item.resource.filePath}">
                                                <button class="btnread" >Download</button>
                                            </a>
                                        </g:else>
                                    </div>
                                    <div class="col-4">
                                        <button id="${item.id}" class="btnread markRead">Mark Read</button>
                                    </div>
                                    <div class="col-2">
                                        <g:link value="${item.resource.topic.name}" params="[topicId: item.resource.topic.id , resourceId : item.resource.id]" controller="postShow" action="index">
                                            <button class="btnread">Post</button>
                                        </g:link>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </g:each>
                        </tbody>
                    </table>
                </div>
            </div>

            <script src = "/home/raghavvohra/helloworld/grails-app/assets/javascripts/navbarTemplate.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

            <!-- Load jQuery and Bootstrap JS -->

            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
            <script src="https://cdn.datatables.net/1.10.25/js/dataTables.bootstrap5.min.js"></script>
            <script>
            $(document).ready(function() {
                $('.userTable').DataTable({
                    "lengthChange": false,
                    "searching" : false
                });
                $('.updateSeriousness').on('click', function(event){
                    console.log("subscription id is" + this.id)
                    var selectedOption = $(this).val();
                    console.log("Selected option: " + selectedOption);
                    console.log("Seriousness is clicked")
                    $.ajax({
                        url : "/Subscription/updateSeriousness?subscriptionId="+this.id + "&selectedOption=" + selectedOption ,
                        success : function(response){
                            alert("Seriousness updated successfully")
                            // window.location.reload();
                        }
                    });
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
            });
        </script>
        </main>
    </body>
</html>
