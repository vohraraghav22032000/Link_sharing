
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Load jQuery and Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/dataTables.bootstrap5.min.js"></script>

</head>

<g:each in="${allTopics}" var="item" >
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
                    <div class="row">
                        <div class="col-6">
                            <g:link  value="${item.name}" params="[topicId: item.id]" controller="topicShow" action="index">
                                <p>${item.name}</p>
                            </g:link>
                        </div>
                        <div class="col-6">
                            <g:link controller="Dashboard" action="allUsers" params="[userId : item.createdBy.id]">
                                <p>${item.createdBy.username}</p>
                            </g:link>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <p>Subscriptions: ${topicMap.get(item).subscribedCount}</p>
                        </div>
                        <div class="col-6">
                            <p>Posts : ${topicMap.get(item).postCount}</p>
                        </div>
                    </div>
                    <div class="row">
                        <g:if test="${topicMap.get(item).topicCreatedBy.username!=session.username}">
                            <g:if test="${subscriptionListId.contains(item.id)}">
                                <button id = "${item.id}"  class="unsubscribeBtn btn btn-dark">Unsubscribe</button>
                            </g:if>
                            <g:else>
                                <button id = "${item.id}"   class="subscribeBtn btn btn-secondary">Subscribe</button>
                            </g:else>
                        </g:if>
                    </div>
                </div>
            </div>
        </div>
    <hr>
</g:each>

<script>


</script>

