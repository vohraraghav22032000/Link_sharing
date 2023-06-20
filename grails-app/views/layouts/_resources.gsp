<%--
  Created by IntelliJ IDEA.
  User: raghavvohra
  Date: 30/05/23
  Time: 10:11 AM
--%>


<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css" integrity="sha384-b6lVK+yci+bfDmaY1u0zE8YYJt0TZxLEAFyYSLHId4xoVvsrQu3INevFKo+Xir8e" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/dataTables.bootstrap5.min.js"></script>

    <style>
        .btnread{
            border-radius: 20px;
            background: lightblue;
        }
    </style>

</head>

<table id="userTable" class="table table-responsive table-striped"  >
<thead>
<div class="row" style="margin-top: 10px">
    <div class="col-3">
        <h3 style="margin-left: 25px">Posts</h3>
    </div>
    <div class="col-9">
        <g:form class="form-inline my-2 my-lg-0" style="display: flex;" controller="dashboard">
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

<g:each in="${allResources}" var="item">
    <tr>
        <td>
                <div class="container ">
        <div class="row">
            <div class="col-3">
            <g:if test="${item.resource.createdBy.photo}">
                <g:link controller="Dashboard" action="allUsers" params="[userId : item.resource.createdBy.id]">
                    <g:img dir="images" file="${item.resource.createdBy.photo.substring(25)}" style="border: 2px solid black;border-radius: 10px" height="100px" width="100px" margin-right="20px" />
                </g:link>
            </g:if>
            <g:else>
                <g:link controller="Dashboard" action="allUsers" params="[userId : item.user.id]">
                    <img src="${resource(dir: 'images', file: 'defaultImage.png')}" style="border: 2px solid black;border-radius: 10px" height="120px" width="120px" margin-right="20px" alt="Example Image">
                </g:link>
            </g:else>
            </div>

            <div class="col-9">
                <div class="row">
                    <div class="col-4">
                        ${item.resource.createdBy.firstname}
                    </div>
                    <div class="col-4">
                        <g:link controller="Dashboard" action="allUsers" params="[userId : item.resource.createdBy.id]">
                           ${item.resource.createdBy.username}
                        </g:link>
                    </div>
                    <div class="col-4">
                        <g:link id = "topicName" value="${item.resource.topic.name}" params="[topicId: item.resource.topic.id]" controller="topicShow" action="index">${item.resource.topic.name}</g:link>
                    </div>
                </div>
                <div>
                    <p>${item.resource.description}</p>
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
                        <g:if test="${item.resource.class as String == 'class helloworld.LinkResource'}">
                            <a href="${item.resource.url}" target="_blank" >
                                <button class="btnread">Visit</button>
                            </a>
                        </g:if>
                        <g:else>
                            <a href="${item.resource.filePath}" target="_blank" download>
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
            </div>
            </div>
        </div>
        </td>
    </tr>
</g:each>
</tbody>
</table>
<script>
    $(document).ready(function() {
        $('#userTable').DataTable({
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

    });


</script>

