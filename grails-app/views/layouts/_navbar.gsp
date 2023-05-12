
<head>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.0/css/bootstrap.min.css" integrity="sha512-CpPbEViCJZw1fQr1qUn6Tjs9ePavU6J4Q4Oq3UXqKj/4G/teysvOuS7a/zN9rxuK7VgOvbu0lBh8Zdi5ox5+Lw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.0/js/bootstrap.min.js" integrity="sha512-Lep9DTd7VnZv5+Z49WJ5d5ezh7ePc58t8yk/+W1/iXtE+mdtTyCJ0YkYUpI1HlOI0+AWB7FygK6U/gvZUePiHg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>


%{--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"--}%
%{--          integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">--}%

%{--    <script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"--}%
%{--            integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"--}%
%{--            crossorigin="anonymous"></script>--}%


%{--    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>--}%



</head>

<nav class="navbar navbar-expand-lg navbar-light bg-light justify-content-between">
    <a class="navbar-brand" href="#" style="margin-left: 20px"><strong>Link Sharing</strong></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <form class="form-inline my-2 my-lg-0">
        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
    <ul class="navbar-nav mr-auto">
        <li>
            <div>
%{--                <i class="bi bi-chat-fill"></i>--}%
                %{--            <li class="nav-item">--}%
                %{--                <a class="nav-link" href="#">Create-topic</a>--}%
                %{--            </li>--}%

                <button id="mybtn1" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@mdo"  style="margin-right: 50px; margin-left:50px" ><i class="bi bi-chat-fill"></i></button>

                <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="exampleModalLabel">Enter details for creating new topic</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <g:form controller="Topic" action="saveTopic">
                                    <div class="mb-3">
                                        <label for="topicName" class="col-form-label">Topic's Name</label>
                                        <g:field name="topicName" type="text" class="form-control" id="topicName" />
                                    </div>
                                    <div class="mb-3">
                                        <label for="message-text" class="col-form-label">Choose Visibility of the topic</label>
                                        <select id="selectPicker1" name="visibility" class="form-select form-select-lg mb-3" aria-label=".form-select-lg example">
                                            <option selected>Visibility</option>
                                            <option value="public">Public</option>
                                            <option value="private">Private</option>
                                        </select>
                                    </div>

                                    <div class="modal-footer">
                                        <g:submitButton name="Save" class="btn btn-primary" >Save</g:submitButton>
                                        <g:link controller="Dashboard" action="index" class="btn btn-primary">Cancel</g:link>

                                        %{--<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Save</button>--}%
                                        %{--<button type="button" class="btn btn-primary">Cancel</button>--}%
                                    </div>
                                </g:form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </li>

        <li>
            <div>
%{--                <i class="bi bi-chat-right-dots"></i>--}%
                %{--            <li class="nav-item">--}%
                %{--                <a class="nav-link disabled" href="#">Send Invitation</a>--}%
                %{--            </li>--}%

                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal2" data-bs-whatever="@mdo" style="margin-right: 50px; margin-left:50px"><i class="bi bi-chat-right-dots"></i></button>

                <div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="exampleModalLabel2">Enter details for sending invitation</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <g:form controller="Topic" action="saveTopic">
                                    <div class="mb-3">
                                        <label for="userEmail" class="col-form-label">Enter Email</label>
                                        <g:field name="userEmail" type="email" class="form-control" id="userEmail" />
                                    </div>
                                    <div class="mb-3">
                                        <label for="topic" class="col-form-label">Choose topic</label>
                                        <select name="topic" id="topic" class="form-select form-select-lg mb-3" aria-label=".form-select-lg example">
                                            <option selected>Topic</option>
                                            <option value="public">Public</option>
                                            <option value="private">Private</option>
                                        </select>
                                    </div>

                                    <div class="modal-footer">
                                        <g:submitButton name="Invite" class="btn btn-primary">Invite</g:submitButton>
                                        <g:link controller="Dashboard" action="index" class="btn btn-primary">Cancel</g:link>

                                        %{--<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Save</button>--}%
                                        %{--<button type="button" class="btn btn-primary">Cancel</button>--}%
                                    </div>
                                </g:form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </li>

        <div>
            <li class="nav-item">
%{--                <i class="bi bi-bandaid"></i>--}%
%{--                /<a class="nav-link disabled" href="#">Create Resource</a>--}%
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal3" data-bs-whatever="@mdo" style="margin-right: 50px; margin-left:50px"><i class="bi bi-bandaid"></i></button>

                <div class="modal fade" id="exampleModal3" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="exampleModalLabel">Share Link Resource</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <g:form controller="LinkResource" action="saveLinkResource">
                                    <div class="mb-3">
                                        <label for="linkres" class="col-form-label">Link</label>
                                        <g:field name="linkres" type="text" class="form-control" id="linkres" />
                                    </div>
                                    <div class="mb-3">
                                        <label for="linkdes" class="col-form-label">Discription</label>
                                        <textarea class="form-control" id="linkdes" name="linkdes" rows="3"></textarea>
%{--                                        <g:field name="topicName" type="textArea" class="form-control" id="topicName" />--}%
                                    </div>
                                    <label for="linkTopic" class="col-form-label">Choose topic</label>
                                    <select name="linkTopic" id="linkTopic" class="form-select form-select-lg mb-3" aria-label=".form-select-lg example">
                                        <option selected>Topic</option>
%{--                                        <option value="public">Public</option>--}%
%{--                                        <option value="private">Private</option>--}%
                                        <g:each in="${subscriptionList}" var="item">
                                            <option value="${item.topic.name}">${item.topic.name}</option>
                                        </g:each>

                                    </select>
                                    <div class="modal-footer">
                                        <g:submitButton name="Save" class="btn btn-primary">Share</g:submitButton>
                                        <g:link controller="Dashboard" action="index" class="btn btn-primary">Cancel</g:link>

                                        %{--<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Save</button>--}%
                                        %{--<button type="button" class="btn btn-primary">Cancel</button>--}%
                                    </div>
                                </g:form>
                            </div>
                        </div>
                    </div>
                </div>
            </li>
        </div>

        <div>
            <li class="nav-item">
%{--                <i class="bi bi-paperclip"></i>--}%
                %{--                /<a class="nav-link disabled" href="#">Create Resource</a>--}%
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal4" data-bs-whatever="@mdo" style="margin-right: 50px; margin-left:50px"><i class="bi bi-paperclip"></i></button>

                <div class="modal fade" id="exampleModal4" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="exampleModalLabel">Share Document Resource</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
%{--                                <label for="exampleFormControlFile1">Example file input</label>--}%
                            </div>
                            <div class="modal-body">
                                <g:form controller="DocumentResource" action="saveDocumentResource">
                                    <div class="mb-3">
                                        <label for="docpath" class="col-form-label">Link</label>
                                        <input type="file" class="form-control-file" id="docpath" name="docpath">
%{--                                        <g:field name="topicName" type="text" class="form-control" id="topicName" />--}%
                                    </div>
                                    <div class="mb-3">
                                        <label for="docdes" class="col-form-label">Discription</label>
                                        <textarea class="form-control" id="docdes" name = "docdes" rows="3"></textarea>
                                        %{--                                        <g:field name="topicName" type="textArea" class="form-control" id="topicName" />--}%
                                    </div>
                                    <label for="docTopic" class="col-form-label">Choose topic</label>
                                    <select name="docTopic" class="form-select form-select-lg mb-3" id="docTopic" aria-label=".form-select-lg example">
                                        <option selected>Topic</option>
                                        <g:each in="${subscriptionList}" var="item">
                                            <option value="${item.topic.name}">${item.topic.name}</option>
                                        </g:each>
                                    </select>
                                    <div class="modal-footer">
                                        <g:submitButton name="Save" class="btn btn-primary">Share</g:submitButton>
                                        <g:link controller="Dashboard" action="index" class="btn btn-primary">Cancel</g:link>

                                        %{--<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Save</button>--}%
                                        %{--<button type="button" class="btn btn-primary">Cancel</button>--}%
                                    </div>
                                </g:form>
                            </div>
                        </div>
                    </div>
                </div>
            </li>
        </div>

        <div class="btn-group">
            <i class="bi bi-person"></i>
            <button type="button" class="btn btn-info dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false" style="margin-right: 20px; margin-left:5px">
                ${session.username}
            </button>


            <g:if test="${isAdmin}">
                <ul class="dropdown-menu">
                    <li><g:link class= "dropdown-item" controller="admin" action="profileView" >Profile</g:link></li>
                    <li><g:link class= "dropdown-item" controller="admin" action="usersView" >Users</g:link></li>
                    <li><g:link class= "dropdown-item" controller="admin" action="topicsView" >Topics</g:link></li>
                    <li><g:link class= "dropdown-item" controller="admin" action="postsView" >Posts</g:link></li>
                    <li><hr class="dropdown-divider"></li>
                    <g:link class= "dropdown-item" controller="login" action="logoutUser" >Logout</g:link>
                </ul>
            </g:if>
            <g:else>
                <ul class="dropdown-menu">
                    <li><g:link class= "dropdown-item" controller="admin" action="profileView" >Profile</g:link></li>
%{--                    <li><g:link class= "dropdown-item" controller="admin" action="usersView" >Users</g:link></li>--}%
%{--                    <li><g:link class= "dropdown-item" controller="admin" action="topicsView" >Topics</g:link></li>--}%
%{--                    <li><g:link class= "dropdown-item" controller="admin" action="postsView" >Posts</g:link></li>--}%
                    <li><hr class="dropdown-divider"></li>
                    <g:link class= "dropdown-item" controller="login" action="logoutUser" >Logout</g:link>
                </ul>
            </g:else>
        </div>
    </ul>
</nav>


<script>

    $("#selectPicker1").click(function(){

        console.log("clicked")

        $.ajax({url: "/topic/getAllPosts", success: function(result){
                console.log(result)
            }});
    });


</script>



%{--        <div>--}%
%{--            <i class="bi bi-chat-right-dots"></i>--}%
%{--            <li class="nav-item">--}%
%{--                <g:link controller="login" action="logoutUser" >Logout</g:link>--}%
%{--            </li>--}%
%{--        </div>--}%
%{--        <li class="nav-item dropdown">--}%
%{--            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">--}%
%{--                ${session.username}--}%
%{--            </a>--}%
%{--            <div class="dropdown-menu" aria-labelledby="navbarDropdown">--}%
%{--                <a class="dropdown-item" href="#">Action</a>--}%
%{--                <a class="dropdown-item" href="#">Another action</a>--}%
%{--                <div class="dropdown-divider"></div>--}%
%{--                <g:link controller="login" action="logoutUser" >Logout</g:link>--}%
%{--            </div>--}%
%{--        </li>--}%

%{--<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" data-whatever="@getbootstrap">Open modal for @getbootstrap</button>--}%

%{--<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">--}%
%{--    <div class="modal-dialog" role="document">--}%
%{--        <div class="modal-content">--}%
%{--            <div class="modal-header">--}%
%{--                <h5 class="modal-title" id="exampleModalLabel">New message</h5>--}%
%{--                <button type="button" class="close" data-dismiss="modal" aria-label="Close">--}%
%{--                    <span aria-hidden="true">&times;</span>--}%
%{--                </button>--}%
%{--            </div>--}%
%{--            <div class="modal-body">--}%
%{--                <form>--}%
%{--                    <div class="form-group">--}%
%{--                        <label for="recipient-name" class="col-form-label">Recipient:</label>--}%
%{--                        <input type="text" class="form-control" id="recipient-name">--}%
%{--                    </div>--}%
%{--                    <div class="form-group">--}%
%{--                        <label for="message-text" class="col-form-label">Message:</label>--}%
%{--                        <textarea class="form-control" id="message-text"></textarea>--}%
%{--                    </div>--}%
%{--                </form>--}%
%{--            </div>--}%
%{--            <div class="modal-footer">--}%
%{--                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>--}%
%{--                <button type="button" class="btn btn-primary">Send message</button>--}%
%{--            </div>--}%
%{--        </div>--}%
%{--    </div>--}%
%{--</div>--}%

%{--<script src = "/home/raghavvohra/helloworld/grails-app/assets/javascripts/navbarTemplate.js"></script>--}%