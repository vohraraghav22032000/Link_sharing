<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'homePage.css')}">
</head>
<body>
<header>
    <h1>Link Sharing</h1>
    <div class="search-box">
        <input type="text" placeholder="Search...">
        <button>Search</button>
    </div>
</header>

<main>
    <div class="sidebar-left">
        <h2>Recent Shares</h2>
        <div class="status-container">
            We have ${posts.size()} Recent posts
            <ul>
                <g:each in="${posts}" var="item">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-6">
                                <img src="${resource(dir: 'images', file: 'defaultImage.png')}" alt="Example Image">
%{--                            <g:img dir="images" file="${item.createdBy.photo}" alt="User Image" class="img-fluid"/>--}%
                            </div>
                            <div class="col-md-6">
                                <h2 class="user-name">${item.createdBy.firstname} ${item.createdBy.lastname} created ${item.name}</h2>
                                <p class="user-description">John Doe is a software engineer who loves to code and build new things. He has a passion for technology and enjoys working on complex projects.</p>
                            </div>
                        </div>
                    </div>
                </g:each>
            </ul>
        </div>
        <h2>Top Posts</h2>
        <div class="top-posts">
            <div class="post">
                <h3>Example post title</h3>
                <p>Example post content</p>
            </div>
            <div class="post">
                <h3>Another example post title</h3>
                <p>Another example post content</p>
            </div>
        </div>
    </div>
    <div class="sidebar-right">
        <div class="login-form">
            <h2>Login</h2>
            <g:form controller="login" action="loginUser">
                <label for="email">Email/Username:</label>
                <input type="text" id="email" name="email">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password">
                <div class="form-links">
                    <a href="#">Forgot password?</a>
                    <input type="submit" value="Login">
                </div>
            </g:form>
        </div>

        <div class="register-form">
            <h2>Register</h2>
            <g:form controller="register" action="registerUser">
                <label for="firstname">First Name:</label>
                <input type="text" id="firstname" name="firstname">
                <label for="lastname">Last Name:</label>
                <input type="text" id="lastname" name="lastname">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password">
                <label for="confirmpassword">Confirm Password:</label>
                <input type="password" id="confirmpassword" name="confirmpassword">
                <label for="photo">Photo:</label>
                <input type="file" id="photo" name="photo">
                <input type="submit" value="Register">
            </g:form>
        </div>
    </div>
</main>
</body>
</html>