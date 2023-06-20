<h2>Your Profile</h2>
<hr>
<div class="container">
    <div class="row">
        <div class="col-4">
            <g:if test="${user.photo}">
                <g:link controller="admin" action="profileView">
                    <g:img dir="images" file="${user.photo.substring(25)}" style="border: 2px solid black;border-radius: 10px" height="100px" width="120px" />
                </g:link>
            </g:if>
            <g:else>
                <g:link controller="admin" action="profileView">
                    <img src="${resource(dir: 'images', file: 'defaultImage.png')}" style="border: 2px solid black;border-radius: 10px" height="100px" width="120px" alt="Example Image">
                </g:link>
            </g:else>
        </div>
        <div class="col-8">
            <h4>${user.firstname} ${user.lastname}</h4>
            <g:link controller="admin" action="profileView">
                <h6>${session.username}</h6>
            </g:link>
            <div class="row">
                <div class="col-6">
                    <button id="mybtn1" type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#subscription" data-bs-whatever="@mdo"  >Subscriptions:${subscribedCount}</button>

                    <div class="modal fade" id="subscription" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalLabel">View all Subscriptions</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">

                                    <g:each in="${subscriptionList}" var="item" >
                                        <div class="container">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <g:if test="${item.topic.createdBy.photo}">
                                                        <g:img dir="images" file="${item.topic.createdBy.photo.substring(25)}" style="border: 2px solid black;border-radius: 10px" height="70px" width="70px"/>
                                                    </g:if>
                                                    <g:else>
                                                        <img src="${resource(dir: 'images', file: 'defaultImage.png')}" style="border: 2px solid black;border-radius: 10px" height="70px" width="70px" alt="Example Image">
                                                    </g:else>
                                                </div>
                                                <div class="col-md-8">
                                                    <g:link id = "topicName" value="${item.topic.name}" params="[topicId: item.topic.id]" controller="topicShow" action="index">${item.topic.name}</g:link>
                                                    <g:link controller="Dashboard" action="allUsers" params="[userId : item.topic.createdBy.id]">
                                                        <div>${item.topic.createdBy.username}</div>
                                                    </g:link>
                                                    <div class="row">
                                                        <div class="col-6">
                                                        </div>
                                                        <div class="col-6">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <hr>
                                    </g:each>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-6">
                    <button id="topic" type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#topics" data-bs-whatever="@mdo"  >Topics:${topicCount}</button>

                    <div class="modal fade" id="topics" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalLabel">View all Topics Created By You</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <g:each in="${topicCreatedByUserList}" var="item" >
                                        <div class="container">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <g:if test="${item.createdBy.photo}">
                                                        <g:img dir="images" file="${item.createdBy.photo.substring(25)}" style="border: 2px solid black;border-radius: 10px" height="70px" width="90px"/>
                                                    </g:if>
                                                    <g:else>
                                                        <img src="${resource(dir: 'images', file: 'defaultImage.png')}" style="border: 2px solid black;border-radius: 10px" height="70px" width="90px" alt="Example Image">
                                                    </g:else>
                                                </div>
                                                <div class="col-md-8">
                                                    <g:link id = "topicNameModal" value="${item.name}" params="[topicId: item.id]" controller="topicShow" action="index">${item.name}</g:link>
                                                    <div class="row">
                                                        <div class="col-7">
                                                            <p><strong>Subscriptions:</strong>${topicMap.get(item).subscribedCount}</p>
                                                        </div>
                                                        <div class="col-5">
                                                            <p><strong>Posts:</strong>${topicMap.get(item).postCount}</p>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                        <hr>
                                    </g:each>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



<script>


    $(document).ready(function() {
        $('#topicNameModal').click(function (event){
            $.ajax({
                url : "/topicShow/index?topicId="+params.topicId, success : function(response){
                    // window.location.reload();
                }
            });
        });

        $('.deleteBtn').click(function (event){
            var topicId = this.id
            console.log("raghav")
            console.log(topicId)
            $.ajax({
                url : "/topic/deleteTopic?topicId="+topicId, success : function(response){
                    window.location.reload();
                }
            });
        });


    });

</script>
