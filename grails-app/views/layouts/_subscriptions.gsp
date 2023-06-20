
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/dataTables.bootstrap5.min.js"></script>

</head>

<table id="SubscriptionDataTable" class="table table-striped" width="100%">
    <thead>
    <tr>
        <th class="th-sm">
        </th>
    </tr>
    </thead>
    <tbody>

        <g:each in="${subscriptionList}" var="item" >
            <tr>
                <td>
                    <div class="container">
                        <div class="row">
                            <div class="col-md-3">
                                <g:if test="${item.topic.createdBy.photo}">
                                    <g:link controller="Dashboard" action="allUsers" params="[userId : item.topic.createdBy.id]">
                                        <g:img dir="images" file="${item.topic.createdBy.photo.substring(25)}"  style="border: 2px solid black;border-radius: 10px" height="70px" width="70px"/>
                                    </g:link>
                                </g:if>
                                <g:else>
                                    <g:link controller="Dashboard" action="allUsers" params="[userId : item.topic.createdBy.id]">
                                      <img src="${resource(dir: 'images', file: 'defaultImage.png')}"  style="border: 2px solid black;border-radius: 10px" height="70px" width="70px" alt="Example Image">
                                    </g:link>
                                </g:else>
                            </div>
                            <div class="col-md-9">
                                <div class="row">
                                    <div class="col-8">
                                        <g:link class= "topicName-${item.topic.id}"  value="${item.topic.name}" params="[topicId: item.topic.id]" controller="topicShow" action="index">
                                            ${item.topic.name}
                                        </g:link>
                                        <button id="save-${item.topic.id}" value="saveBtn" name="saveBtn" class="btn btn-success subscriptionSaveBtn offset-1" onclick="saveTopicName()" style="display: none">Save</button>
                                        <button id="cancel-${item.topic.id}" value="cancelBtn" name="cancelBtn" class="btn btn-danger subscriptionCancelBtn" onclick="cancelTopicName()" style="display: none">Cancel</button>

                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col-4">
                                         <g:link controller="Dashboard" action="allUsers" params="[userId : item.topic.createdBy.id]">
                                            <h6>${item.topic.createdBy.username}</h6>
                                         </g:link>
                                    </div>
                                    <div class="col-4">
                                        <g:link controller="Dashboard" action="allUsers" params="[userId : item.topic.createdBy.id]">
                                            <p><strong>Subscriptions:</strong>${topicMap.get(item.topic).subscribedCount}</p>
                                        </g:link>
                                    </div>
                                    <div class="col-4">
                                        <g:link controller="Dashboard" action="allUsers" params="[userId : item.topic.createdBy.id]">
                                            <p><strong>Posts:</strong>${topicMap.get(item.topic).postCount}</p>
                                        </g:link>
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col-4">
                                        <g:if test="${!topicCreatedByUserName.contains(item.topic.name)}">
                                            <g:if test="${topicMap.get(item.topic).topicCreatedBy.username!=session.username}">
                                                <g:if test="${subscriptionListName.contains(item.topic.name)}">
                                                    <button id = "${item.topic.id}" class="unsubscribeBtn2 btn btn-dark">Unsubscribe</button>
                                                </g:if>

                                                <g:else>
                                                    <button id = "${item.topic.id}" class="subscribeBtn2 btn btn-secondary">Subscribe</button>
                                                </g:else>
                                            </g:if>
                                        </g:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="my-section d-flex justify-content-between align-items-center">
                        <div>
                            <g:select name="${item.id}" id="${item.id}" class="updateSeriousness" from="${['CASUAL','SERIOUS','VERY_SERIOUS'] -
                                    ["${item.seriousness}"]}" value="${item.seriousness}"
                                      noSelection="${['':item.seriousness]}" />
                        </div>

                        <g:if test="${isAdmin || topicCreatedByUserName.contains(item.topic.name)}">
                            <div>
                                <g:select name="${item.topic.id}" id="${item.topic.id}" class="updateVisibility" from="${['PUBLIC','PRIVATE'] -
                                        ["${item.topic.visibility}"]}" value="${item.topic.visibility}"
                                          noSelection="${['':item.topic.visibility]}" />
                            </div>
                        </g:if>

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
                        <g:if test="${isAdmin || topicCreatedByUserName.contains(item.topic.name)}">
                            <button id="${item.topic.id}" class="edit-button btn btn-success"><i class="bi bi-pencil-square"></i></button>
                        </g:if>

                        <g:if test="${isAdmin || topicCreatedByUserName.contains(item.topic.name)}">
                            <button id = "${item.topic.id}" class="deleteBtn btn btn-danger"><i class="bi bi-trash3-fill"></i></button>
                        </g:if>
                    </div>
                </td>
            </tr>
        </g:each>
    </tbody>
</table>

<script>


    $(document).ready(function() {
        $('.subscribeBtn2').click(function (event){
            console.log("raghav")
            var topicId = this.id
            console.log(topicId)
            $.ajax({
                url : "/Subscription/addSubscription?topicId="+topicId, success : function(response){
                    window.location.reload();
                }
            });
        });

        $('.unsubscribeBtn2').click(function (event){
            console.log("unsubscribed btn is clicked")

            var topicId = this.id
            console.log(topicId)
            $.ajax({
                url : "/Subscription/deleteSubscription?topicId="+topicId, success : function(response){
                    window.location.reload();
                }
            });
        });

        $(".edit-button").click(function(){
            console.log("edit button clicked")
            console.log(this.id)
            let tag = document.querySelector('.topicName-' + this.id);
            let saveBtn = document.querySelector('#save-'+this.id);
            let cancelBtn = document.querySelector('#cancel-'+this.id);
            console.log(saveBtn, cancelBtn , tag);
            tag.contentEditable = true;
            tag.focus()
            saveBtn.style.display = "inline-block"
            cancelBtn.style.display = "inline-block"
        });

        $('.topicName').click(function (event){
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

    });

    function cancelTopicName(){
        console.log("cancel button clicked")
        let id = event.target.id.substring(7)
        console.log("id is + " + id)
        // console.log(this.id)

        let tag = document.querySelector('.topicName-' + id);
        let saveBtn = document.querySelector('#save-'+id);
        let cancelBtn = document.querySelector('#cancel-'+id);
        // tag.style.maxlength="4"
        saveBtn.style.display = "none"
        cancelBtn.style.display = "none"
        tag.contentEditable = false;
        window.location.reload();
    }
    function saveTopicName(){
        console.log("save button clicked")
        let id = event.target.id.substring(5)
        console.log("id is + " + id)

        let tag = document.querySelector('.topicName-' + id);
        let saveBtn = document.querySelector('#save-'+id);
        let cancelBtn = document.querySelector('#cancel-'+id);
        let topicName = tag.text
        // tag.style.maxlength="4"
        saveBtn.style.display = "none"
        cancelBtn.style.display = "none"
        tag.contentEditable = false;
        $.ajax({url: "/topic/updateTopicName?topicId="+id+"&newTopicName="+topicName
            , success: function(result){
                window.location.reload();
                // alert("Topic name updated successfully")
            }, error: function(response) {
                alert("Please enter correct topic name");
                window.location.reload();
            }
        });
    }

</script>

