
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