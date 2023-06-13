<%--
  Created by IntelliJ IDEA.
  User: raghavvohra
  Date: 05/06/23
  Time: 11:29 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head> <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css" integrity="sha384-b6lVK+yci+bfDmaY1u0zE8YYJt0TZxLEAFyYSLHId4xoVvsrQu3INevFKo+Xir8e" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'homePage.css')}">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.0/css/bootstrap.min.css" integrity="sha512-CpPbEViCJZw1fQr1qUn6Tjs9ePavU6J4Q4Oq3UXqKj/4G/teysvOuS7a/zN9rxuK7VgOvbu0lBh8Zdi5ox5+Lw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.0/js/bootstrap.min.js" integrity="sha512-Lep9DTd7VnZv5+Z49WJ5d5ezh7ePc58t8yk/+W1/iXtE+mdtTyCJ0YkYUpI1HlOI0+AWB7FygK6U/gvZUePiHg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

    <style>
    .btnread{
        border-radius: 20px;
        background: lightblue;
    }
    </style>

</head>
<g:render template="/layouts/profileNavbar" model="[isAdmin : isAdmin]"/>
<main>
    <body>


        <div class="sidebar-left">
            <div class="container">
                <div style="border: 2px solid black;border-radius : 10px">
                    <h3 style="margin-left: 15px">Profile</h3>
                    <hr>
%{--                    <p>user id : ${userProfile}</p>--}%
                    <div class="row" style="margin-bottom: 10px">
                        <div class="col-md-3" >
                            <g:if test="${userProfile.photo}">
                                <g:img dir="images" file="${userProfile.photo.substring(25)}" style="border: 2px solid black;border-radius: 10px;margin-left: 10px" height="70px" width="70px" margin-left="10px"/>
                            </g:if>
                            <g:else>
                                <img src="${resource(dir: 'images', file: 'defaultImage.png')}" style="border: 2px solid black;border-radius: 10px;margin-left: 10px"  height="70px" width="70px" margin-left="10px" alt="Example Image">
                            </g:else>
                        </div>
                        <div class="col-md-9">
                            <div class="row">
                                <div class="col-6">
                                    <h5>${userProfile.firstname} ${userProfile.lastname}</h5>
                                </div>
                                <div class="col-6">
                                    <h4>${userProfile.username}</h4>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-6">
                                    <h4>Subscriptions : ${userSubscriptions.size()}</h4>
                                </div>
                                <div class="col-6">
                                    <h4>Topics : ${userTopics.size()}</h4>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <div class="container">
                <div style="border: 2px solid black;border-radius : 10px;margin-top : 10px">
                    <h3 style="margin-left: 15px">Topics</h3>
%{--                    <hr>--}%
                    <table  class="table allUsersTable table-striped" width="100%">
                        <thead>
                        <tr>
                            <th class="th-sm">
                            </th>
                        </tr>
                        </thead>
                        <tbody>

                        <g:each in="${userTopics}" var="item">
                            <tr>
                                <td>
                                    <g:link  params="[topicId: item.id]" controller="topicShow" action="index">
                                        <h5 style="margin-left: 15px">${item.name}</h5>
                                    </g:link>
                                    <div class="row">
                                        <div class="col-2">

                                        </div>
                                        <div class="col-4">
                                            Subscriptions : ${topicMap.get(item).subscribedCount}
                                        </div>
                                        <div class="col-6">
                                            Posts : ${topicMap.get(item).postCount}
                                        </div>
                                    </div>
                                </td>
                            </tr>

%{--                        <hr>--}%
                    </g:each>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="container">
                <div style="border: 2px solid black;border-radius : 10px;margin-top: 10px">
                    <h3 style="margin-left: 15px">Subscriptions</h3>
%{--                    <hr>--}%
                    <table  class="table allUsersTable table-striped" width="100%">
                        <thead>
                        <tr>
                            <th class="th-sm">
                            </th>
                        </tr>
                        </thead>
                        <tbody>

                    <g:each in="${userSubscriptions}" var="item">
                        <tr>
                            <td>
                                <div class="row">
                                    <div class="col-3">
                                        <g:if test="${item.topic.createdBy.photo}">
                                            <g:img dir="images" file="${item.topic.createdBy.photo.substring(25)}" height="70px" width="80px" style="border: 2px solid black;border-radius: 10px;margin-left: 10px"/>
                                        </g:if>
                                        <g:else>
                                            <img src="${resource(dir: 'images', file: 'defaultImage.png')}" height="70px" width="80px" style="border: 2px solid black;border-radius: 10px;margin-left: 10px" alt="Example Image">
                                        </g:else>
                                    </div>
                                    <div class="col-9">
                                        <div class="row">
                                            <div class="col-6">
                                                <g:link params="[topicId: item.topic.id]" controller="topicShow" action="index">
                                                    <p>${item.topic.name}</p>
                                                </g:link>
                                            </div>
                                            <div class="col-6">
                                                <g:link controller="Dashboard" action="allUsers" params="[userId : item.topic.createdBy.id]">
                                                    <p>${item.topic.createdBy.username}</p>
                                                </g:link>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-6">
                                                <p>Subscriptions : ${topicMap.get(item.topic).subscribedCount}</p>
                                            </div>
                                            <div class="col-6">
                                                <p>Posts : ${topicMap.get(item.topic).postCount}</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
%{--                        <hr>--}%
                    </g:each>
                        </tbody>
                </table>
                </div>
            </div>
        </div>
        <div class="sidebar-right">
            <div class="container">
                <div style="border: 2px solid black;border-radius : 10px">
                    <h3 style="margin-left: 15px">Resources</h3>
%{--                    <hr>--}%
                    <table  class="table allUsersTable table-striped" width="100%">
                        <thead>
                        <tr>
                            <th class="th-sm">
                            </th>
                        </tr>
                        </thead>
                        <tbody>

                    <g:each in="${userResources}" var="item">
                        <tr>
                            <td>
                                <h5 style="margin-left: 15px">${item.topic.name}</h5>
                                <p style="margin-left: 15px">${item.description}</p>
                                <div class="row">
                                    <div class="col-1">

                                    </div>
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
                                            <a href="${item.url}" target="_blank" >
                                                <button class="btnread">View Site</button>
                                            </a>
                                        </g:if>
                                        <g:else>
                                            <a href="${item.filePath}"  download>
                                                <button class="btnread" >Download Post</button>
                                            </a>
                                        </g:else>
                                    </div>
                                    <div class="col-4">
                                        <g:link value="${item.topic.name}" params="[topicId: item.topic.id , resourceId : item.id]" controller="postShow" action="index">
                                            <button class="btnread">View Post</button>
                                        </g:link>
                                    </div>
                                </div>
                            </td>
                        </tr>

%{--                        <hr>--}%
                    </g:each>
                        </tbody>
                </table>
                </div>
            </div>
        </div>
    </body>
</main>
</html>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.25/js/dataTables.bootstrap5.min.js"></script>

<script>
    $(document).ready(function() {
        $('.allUsersTable').DataTable({
            "lengthChange": false,
            "searching" : false
        });
    });
</script>