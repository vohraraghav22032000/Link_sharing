<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users Page</title>
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
    #usersTable{
        border: 2px solid black;
        border-collapse: separate !important;
        border-radius: 20px ;
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

    <g:render template="/layouts/topicPostNavbar" model="[subscriptionList : subscriptionList , isAdmin : isAdmin]"/>
                <div class="container " style="margin-top: 50px">
                    <table class="table table-responsive table-striped dataTables_length" id="usersTable">
                        <thead>
                        <tr>
                            <th><i class="bi bi-sort-up"></i>ID</th>
                            <th><i class="bi bi-sort-up"></i>Username</th>
                            <th><i class="bi bi-sort-up"></i>Email</th>
                            <th><i class="bi bi-sort-up"></i>First Name</th>
                            <th><i class="bi bi-sort-up"></i>Last Name</th>
                            <th><i class="bi bi-sort-up"></i>Active</th>
                            <th><i class="bi bi-sort-up"></i>Manage</th>
                        </tr>
                        </thead>
                        <tbody>
                            <g:each in="${allUsers}" var="item">
                                <tr>
                                    <td>${item.id}</td>
                                    <td>${item.username}</td>
                                    <td>${item.email}</td>
                                    <td>${item.firstname}</td>
                                    <td>${item.lastname}</td>
                                    <g:if test="${item.active}">
                                        <td>Yes</td>
                                    </g:if>
                                    <g:else>
                                        <td>No</td>
                                    </g:else>
                                    <g:if test="${item.active}">
                                        <td><button id="${item.id}" class="deactive btn btn-danger">Deactivate</button></td>
                                    </g:if>
                                    <g:else>
                                        <td><button id="${item.id}" class="active btn btn-primary">Activate</button></td>
                                    </g:else>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>

    <script src = "/home/raghavvohra/helloworld/grails-app/assets/javascripts/navbarTemplate.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

    <!-- Load jQuery and Bootstrap JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/dataTables.bootstrap5.min.js"></script>

    <script>

            $(document).ready(function() {
                $('#usersTable').DataTable({
                    bJQueryUI: true,
                    sPaginationType: "full_numbers",
                    cache: false,
                    height: 400,
                    striped: true,
                    pagination: true,
                    pageSize: 5, //specify 5 here
                    pageList: [5, 10, 25, 50, 100],
                    showButtonIcons: true,
                });
                $("body").on('click', '.deactive', function (e){
                    var userId = this.id
                    console.log("raghav")
                    console.log(userId)
                    $.ajax({
                        url : "/register/deactivateUser?userId="+userId, success : function(response){
                            // alert("Topic deleted successfully");
                            window.location.reload();
                        }
                    });
                });
                $("body").on('click', '.active', function (e){
                    var userId = this.id
                    console.log("raghav")
                    console.log(userId)
                    $.ajax({
                        url : "/register/activateUser?userId="+userId, success : function(response){
                            // alert("Topic deleted successfully");
                            window.location.reload();
                        }
                    });
                });
            });
        </script>
    </body>
</html>


