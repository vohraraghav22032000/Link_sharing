<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Profile Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css" integrity="sha384-b6lVK+yci+bfDmaY1u0zE8YYJt0TZxLEAFyYSLHId4xoVvsrQu3INevFKo+Xir8e" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'homePage.css')}">
        <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'dashBoard.css')}">

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.25/js/dataTables.bootstrap5.min.js"></script>
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
                    <g:render template="/layouts/profile" model="[user : user ,subscriptionList : subscriptionList , isAdmin : isAdmin , subscribedCount : subscribedCount , topicCreatedByUserList: topicsCreatedByUserList , topicMap : topicMap]"/>
                </div>
                <div>

                    <div class="trending-topics" id = "content">
                        <div class="row">
                            <div class="col-3">
                                <h2>Topics</h2>
                            </div>
                            <div class="col-9">
                                <g:form class="form-inline my-2 my-lg-0" style="display: flex;" controller="admin" action="editProfileView">
                                    <div class="input-group">
                                        <g:field name="search" style="width: 100px" type="search" placeholder="Search" class="form-control" id="" required="true" />
                                        <div class="input-group-append">
                                            <g:submitButton name="Search" style="margin-left: 20px ;margin-right:20px" class="btn btn-outline-success" type="submit">Search</g:submitButton>
                                        </div>
                                    </div>
                                </g:form>
                            </div>
                        </div>
                        <div>
                        <table id="topicsCreatedByUser" class="table table-striped" width="100%">
                            <thead>
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
                                                <div class="col-md-6">
                                                    <g:link  value="${item.name}" params="[topicId: item.id]" controller="topicShow" action="index">
                                                        <p>${item.name}</p>
                                                    </g:link>
                                                </div>
                                                <div class="col-md-6">
                                                    <p>${session.username}</p>
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-4">
                                                    <p>Subscriptions: ${topicMap.get(item).subscribedCount}</p>
                                                </div>
                                                <div class="col-2">
                                                    <p>Posts : ${topicMap.get(item).postCount}</p>
                                                </div>
                                                <div class="col-3">
                                                    <g:select name="${item.id}" id="${item.id}" class="updateVisibility" from="${['PUBLIC','PRIVATE']-
                                                     ["${item.visibility}"]}" value="${item.visibility}"
                                                                      noSelection="${['':item.visibility]}" />
                                                </div>
                                                <div class="col-1">
                                                    <button id = "${item.id}" class="deleteBtn3 btn btn-danger"><i class="bi bi-trash3-fill"></i></button>
                                                </div>
                                                <div class="col-2">
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
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </g:each>
                            </tbody>
                          </table>
                    </div>
                    </div>
                </div>
            </div>
            <div class="sidebar-right">
                <div class="register-form">
                    <h2>Profile</h2>
                    <g:uploadForm controller="register" action="updateProfile">
                        <label for="firstname">First Name:</label>
                        <input type="text" id="firstname" name="firstname" required pattern="[A-Za-z]{3,}">
                        <label for="lastname">Last Name:</label>
                        <input type="text" id="lastname" name="lastname" required pattern="[A-Za-z]{3,}">
                        <label for="username">Username:</label>
                        <input type="text" id="username" name="username" required >
                        <label for="photo">Photo:</label>
                        <input type="file" id="photo" name="photo">
                        <input type="submit" value="Update" style = "width: 150px;margin-left: 225px;">
                    </g:uploadForm>
                </div>
                <div class="login-form">
                    <h2>Change Password</h2>
                    <g:form name = "updateForm" controller="register" action="updatePassword">
                        <label for="password">Password:</label>
                        <input type="password" id="password" name="password" required pattern="^[^\s]{8,}$"
                               title="Must contain at least 8 or more characters">
                        <label for="confirmpassword">Confirm Password:</label>
                        <input type="password" id="confirmpassword" name="confirmpassword" required pattern="^[^\s]{8,}$"
                               title="Must contain at least 8 or more characters">
                        <input type="submit" value="Update" style = "width: 150px;margin-left: 225px;">
                    </g:form>
                </div>
            </div>
        </main>
        <script src = "/home/raghavvohra/helloworld/grails-app/assets/javascripts/navbarTemplate.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.25/js/dataTables.bootstrap5.min.js"></script>

        <script>

            $(document).ready(function() {
                $('#topicsCreatedByUser').DataTable({
                    "lengthChange": false,
                    "searching" : false
                });
                $('.deleteBtn3').click(function (event){
                    var topicId = this.id
                    console.log("raghav")
                    console.log(topicId)
                    $.ajax({
                        url : "/topic/deleteTopic?topicId="+topicId,
                        success : function(response){
                            console.log(response)
                            // alert("Topic deleted successfully")
                            window.location.reload();
                        }
                    });
                });
                $('.updateVisibility').click(function (event){
                    var selectedOption = $(this).val();
                    var topicId = this.id
                    console.log("visibility is clicked")
                    console.log("topic id is " + this.id)
                    $.ajax({
                        url : "/topic/updateVisibility?topicId="+topicId + "&selectedOption=" + selectedOption
                        , success : function(response){
                            // window.location.reload();
                            alert("Visibility updated successfully")
                        }
                    });
                });
            });

        </script>
    </body>
</html>
