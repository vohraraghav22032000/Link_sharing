<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Posts Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css" integrity="sha384-b6lVK+yci+bfDmaY1u0zE8YYJt0TZxLEAFyYSLHId4xoVvsrQu3INevFKo+Xir8e" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'dashBoard.css')}">

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

    <g:render template="/layouts/topicPostNavbar" model="[subscriptionList:subscriptionList, isAdmin : isAdmin]" />
        <div class="container" style="margin-top: 50px">
            <div class="row">
                <div class="col-md-12">
                    <table class="table table-striped" id="usersTable">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th><i class="bi bi-sort-up"></i>Description</th>
                            <th><i class="bi bi-sort-up"></i>Topic Name</th>
                            <th><i class="bi bi-sort-up"></i>Created By</th>
                            <th><i class="bi bi-sort-up"></i>Date Created</th>
                            <th><i class="bi bi-sort-up"></i>Last Updated</th>
                            <th><i class="bi bi-sort-up"></i>Manage</th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${allResource}" var="item">
                            <tr>
                                <td>${item.id}</td>
                                <td>${item.description}</td>
                                <td>${item.topic.name}</td>
                                <td>${item.createdBy.firstname} ${item.createdBy.lastname}</td>
                                <td>${item.dateCreated}</td>
                                <td>${item.lastUpdated}</td>
                                <td>
                                    <button id = "${item.id}" class="deleteBtn btn btn-primary">Delete</button>
                                </td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    <script src = "/home/raghavvohra/helloworld/grails-app/assets/javascripts/navbarTemplate.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

    <!-- Load jQuery and Bootstrap JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/dataTables.bootstrap5.min.js"></script>
        <!-- Initialize DataTable -->
        <script>
            $(document).ready(function() {
                $("body").on('click', '.deleteBtn', function (e){
                    $.ajax({
                        url : "/documentResource/deletePost?resourceId="+this.id, success : function(response){
                            window.location.reload();
                        }
                    });
                });
            });
        </script>
    </body>
</html>
