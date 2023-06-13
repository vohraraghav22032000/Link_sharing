<%--
  Created by IntelliJ IDEA.
  User: raghavvohra
  Date: 05/06/23
  Time: 3:50 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.0/css/bootstrap.min.css" integrity="sha512-CpPbEViCJZw1fQr1qUn6Tjs9ePavU6J4Q4Oq3UXqKj/4G/teysvOuS7a/zN9rxuK7VgOvbu0lBh8Zdi5ox5+Lw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'homePage.css')}">

</head>

<body>

<header>
    <g:link controller="index"><h1>Link Sharing</h1></g:link>
    <g:form class="form-inline my-2 my-lg-0" style="display: flex;align-items: center;" controller="search" action="withoutLogin">
        <g:field name="search" style="margin-left: 360px;width: 225px" type="search" placeholder="Search" class="form-control" id="" required="true" />
        <g:submitButton name="Search" class="btn btn-outline-success my-2 my-sm-0" style="margin-left: 10px" type="submit">Search</g:submitButton>
    </g:form>
</header>

<main>
    <div class="sidebar-left">
        <div class="status-container">
            <h4>Recent Shares</h4>
            <g:each in ="${recentList}" var = "item">
                <div class="row" style="height: 90px">
                    <div class="col-3">
                        <img src="${resource(dir: 'images', file: 'defaultImage.png')}" margin-left= "20px" margin-right="20px" height="70px" width="70px"alt="Example Image">
                        %{--                            <g:if test="${item.createdBy.photo}">--}%
                        %{--                                <g:img dir="images" file="${item.photo.substring(25)}" margin-left= "20px" margin-right="20px" height="70px" width="70px"/>--}%
                        %{--                            </g:if>--}%
                        %{--                            <g:else>--}%
                        %{--                                <img src="${resource(dir: 'images', file: 'defaultImage.png')}" margin-left= "20px" margin-right="20px" height="70px" width="70px"alt="Example Image">--}%
                        %{--                            </g:else>--}%
                    </div>
                    <div class="col-9">
                        <div class="row">
                            <div class="col-8">
                                <div class="row">
                                    <div class="col-8">
                                        <h5>${item.createdBy.firstname} ${item.createdBy.lastname}</h5>
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
                            <div class="col-4">
                                <g:link id = "topicName2" value="${item.topic.name}" params="[topicId: item.topic.id ,resourceId: item.id]" controller="postShow" action="index">View Post</g:link>
                            </div>
                        </div>
                    </div>
                </div>
            </g:each>
        </div>

    </div>
    <div class="sidebar-right">
        <div class="status-container">
            <h4>Top Posts</h4>
            <g:each in ="${topRatingPost}" var = "item">
                <div class="row" style="height: 90px">
                    <div class="col-3">
                        <img src="${resource(dir: 'images', file: 'defaultImage.png')}" margin-left= "20px" margin-right="20px" height="70px" width="70px"alt="Example Image">
                    </div>
                    <div class="col-9">
                        <div class="row">
                            <div class="col-8">
                                <div class="row">
                                    <div class="col-8">
                                        <h5>${item.user.firstname} ${item.user.lastname}</h5>
                                    </div>
                                    <div class="col-4">
                                        <h5>${item.user.username}</h5>
                                    </div>
                                </div>
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
            </g:each>
        </div>

    </div>
</main>
</body>
</html>