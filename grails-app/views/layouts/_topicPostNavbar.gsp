
<head>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.0/css/bootstrap.min.css" integrity="sha512-CpPbEViCJZw1fQr1qUn6Tjs9ePavU6J4Q4Oq3UXqKj/4G/teysvOuS7a/zN9rxuK7VgOvbu0lBh8Zdi5ox5+Lw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.0/js/bootstrap.min.js" integrity="sha512-Lep9DTd7VnZv5+Z49WJ5d5ezh7ePc58t8yk/+W1/iXtE+mdtTyCJ0YkYUpI1HlOI0+AWB7FygK6U/gvZUePiHg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>


        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">

        <script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
                crossorigin="anonymous"></script>


        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

</head>

<nav class="navbar navbar-expand-lg navbar-light bg-light justify-content-between">
    <g:link controller="Dashboard" action="index" class="navbar-brand" style="margin-left: 20px"><strong>Link Sharing</strong></g:link>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <g:form class="form-inline my-2 my-lg-0" style="display: flex;align-items: center;" controller="search" >
        <g:field name="search" style="margin-left: 460px;width: 225px" type="search" placeholder="Search" class="form-control" id=""  />
        <g:submitButton name="Search" class="btn btn-outline-success my-2 my-sm-0" style="margin-left: 10px" type="submit">Search</g:submitButton>
    </g:form>
    <ul class="navbar-nav mr-auto">
        <div>
            <li class="nav-item">
                <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#exampleModal3" data-bs-whatever="@mdo" style="margin-right: 5px; margin-left:5px"><i class="bi bi-link"></i></button>

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
                                        <g:field name="linkres" type="url" class="form-control" id="linkres" required="true"/>
                                    </div>
                                    <div class="mb-3">
                                        <label for="linkdes" class="col-form-label">Discription</label>
                                        <textarea class="form-control" id="linkdes" name="linkdes" rows="3" required="true"></textarea>
                                    </div>
                                    <label for="linkTopic" class="col-form-label">Choose topic</label>
                                    <select name="linkTopic" id="linkTopic" class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" required="true">
                                        <option value="" selected disabled>Topic</option>
                                        <g:each in="${subscriptionList}" var="item">
                                            <option value="${item.topic.id}" params="[topicSelected : ${item.topic.id}]">${item.topic.name}</option>
                                        </g:each>

                                    </select>
                                    <div class="modal-footer">
                                        <g:submitButton name="Save" class="btn btn-primary">Share</g:submitButton>
                                        <g:link controller="Dashboard" action="index" class="btn btn-primary">Cancel</g:link>
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
                <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#exampleModal4" data-bs-whatever="@mdo" style="margin-right: 5px; margin-left:5px"><i class="bi bi-paperclip"></i></button>

                <div class="modal fade" id="exampleModal4" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="exampleModalLabel">Share Document Resource</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <g:uploadForm controller="DocumentResource" action="saveDocumentResource">
                                    <div class="mb-3">
                                        <label for="docpath" class="col-form-label">Document</label>
                                        <input type="file" class="form-control-file" id="docpath" name="docpath" required="true">
                                    </div>
                                    <div class="mb-3">
                                        <label for="docdes" class="col-form-label">Description</label>
                                        <textarea class="form-control" id="docdes" name = "docdes" rows="3" required="true"></textarea>
                                    </div>
                                    <label for="docTopic" class="col-form-label">Choose topic</label>
                                    <select name="docTopic" class="form-select form-select-lg mb-3" id="docTopic" aria-label=".form-select-lg example" required="true">
                                        <option value="" selected disabled>Topic</option>
                                        <g:each in="${subscriptionList}" var="item">
                                            <option value="${item.topic.id}">${item.topic.name}</option>
                                        </g:each>
                                    </select>
                                    <div class="modal-footer">
                                        <g:submitButton name="Save" class="btn btn-primary">Share</g:submitButton>
                                        <g:link controller="Dashboard" action="index" class="btn btn-primary">Cancel</g:link>
                                    </div>
                                </g:uploadForm>
                            </div>
                        </div>
                    </div>
                </div>
            </li>
        </div>

        <div class="btn-group">
            <g:link class= "dropdown-item" controller="admin" action="profileView" style="border: 1px solid black;border-radius: 5px;margin-left: 5px;margin-right: 5px;width:50px">
                <g:if test="${user.photo}">
                    <g:img dir="images" file="${user.photo.substring(25)}" height="35px" width="48px"/>
                </g:if>
                <g:else>
                    <img src="${resource(dir: 'images', file: 'defaultImage.png')}" height="35px" width="48px" alt="Example Image">
                </g:else>
            </g:link>
            <button type="button" class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false" style="margin-right: 20px; margin-left:5px;border-radius: 20px">
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
                    <li><hr class="dropdown-divider"></li>
                    <g:link class= "dropdown-item" controller="login" action="logoutUser" >Logout</g:link>
                </ul>
            </g:else>
        </div>
    </ul>
</nav>


<script>

    $('#docpath').bind('change', function() {

        //this.files[0].size gets the size of your file.
        if(this.files[0].size/(1024*1024)>20){
            alert("File size limit exceeded");
            window.location.reload()
        }
    });

</script>
