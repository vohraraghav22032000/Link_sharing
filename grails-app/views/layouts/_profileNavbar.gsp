
<head>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
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
        <g:field name="search" style="margin-left: 560px;width: 225px" type="search" placeholder="Search" class="form-control" id="" />
        <g:submitButton name="Search" class="btn btn-outline-success my-2 my-sm-0" style="margin-left: 10px" type="submit">Search</g:submitButton>
    </g:form>
    <ul class="navbar-nav mr-auto">
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
                    <li><g:link class= "dropdown-item" controller="admin" action="editProfileView" >Profile</g:link></li>
                    <li><g:link class= "dropdown-item" controller="admin" action="usersView" >Users</g:link></li>
                    <li><g:link class= "dropdown-item" controller="admin" action="topicsView" >Topics</g:link></li>
                    <li><g:link class= "dropdown-item" controller="admin" action="postsView" >Posts</g:link></li>
                    <li><hr class="dropdown-divider"></li>
                    <g:link class= "dropdown-item" controller="login" action="logoutUser" >Logout</g:link>
                </ul>
            </g:if>
            <g:else>
                <ul class="dropdown-menu">
                    <li><g:link class= "dropdown-item" controller="admin" action="editProfileView" >Profile</g:link></li>
                    <li><hr class="dropdown-divider"></li>
                    <g:link class= "dropdown-item" controller="login" action="logoutUser" >Logout</g:link>
                </ul>
            </g:else>
        </div>
    </ul>
</nav>



