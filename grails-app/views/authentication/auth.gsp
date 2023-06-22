    <%--
      Created by IntelliJ IDEA.
      User: raghavvohra
      Date: 21/06/23
      Time: 2:42 PM
    --%>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.0/css/bootstrap.min.css" integrity="sha512-CpPbEViCJZw1fQr1qUn6Tjs9ePavU6J4Q4Oq3UXqKj/4G/teysvOuS7a/zN9rxuK7VgOvbu0lBh8Zdi5ox5+Lw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'homePage.css')}">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'flashMessage.css')}">

    </head>
    <body>

    <g:if test="${flash.successMessage}">

        <div id="success-message" class="toast show position-fixed top-0 start-50 translate-middle-x" style="z-index: 9999; background-color: darkgrey;">
            <div class="toast-header" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="false">
                <strong class="me-auto">${flash.successMessage}</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
            </div>
        </div>
        </div>

    </g:if>
    <g:if test="${flash.errorMessage}">

        <div id="error-message" class="toast show position-fixed top-0 start-50 translate-middle-x" style="z-index: 9999; background-color: darkgrey;">
            <div class="toast-header" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="false">
                <strong class="me-auto">${flash.errorMessage}</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
            </div>
        </div>
        </div>
    </g:if>

    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        response.setHeader ("Clear-Site-Data", "\"cache\"");
        response.setHeader("Cache-Control", "private, no-store, max-age=0, no-cache, must-revalidate");
    %>

    <header>
        <h1>Link Sharing</h1>
        <g:form class="form-inline my-2 my-lg-0" style="display: flex;align-items: center;" controller="search" action="withoutLogin">
            <g:field name="search" style="margin-left: 360px;width: 225px" type="search" placeholder="Search" class="form-control" id="" required="true" />
            <g:submitButton name="Search" class="btn btn-outline-success my-2 my-sm-0" style="margin-left: 10px" type="submit">Search</g:submitButton>
        </g:form>
    </header>

    <main>

        <div class="sidebar-left">
            <div class="status-container">
                <h4>Recent Shares</h4>
                <hr>
                <g:each in ="${posts}" var = "item">
                    <div class="row" >
                        <div class="col-3"><g:if test="${item.createdBy.photo}">
                            <g:img dir="images" file="${item.createdBy.photo.substring(25)}" style="border: 2px solid black;border-radius: 10px" margin-left= "20px" margin-right="20px" height="70px" width="70px"/>
                        </g:if>
                            <g:else>
                                <img src="${resource(dir: 'images', file: 'defaultImage.png')}" style="border: 2px solid black;border-radius: 10px" margin-left= "20px" margin-right="20px" height="70px" width="70px"alt="Example Image">
                            </g:else>
                        </div>
                        <div class="col-9">
                            <div class="row">
                                <div class="col-4">
                                    <h5>${item.createdBy.firstname}</h5>
                                </div>
                                <div class="col-4">
                                    <h5>${item.createdBy.username}</h5>
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
                    <hr>
                </g:each>
            </div>

            <div class="status-container">
                <div class="row">
                    <div class="col-8">
                        <h4>Top Posts</h4>
                    </div>
                    <div class="col-4">
                        <g:select name="${timeFrame}" id="${timeFrame}" class="timePicker"
                                  from="${['Today', '1 Week', '1 Month', '1 Year'] - ["${timeFrame}"]}"
                                  value="${timeFrame}" noSelection="${['':timeFrame]}" />

                    </div>
                </div>
                <hr>
                <g:each in ="${topRatingPost}" var = "item">
                    <div class="row">
                        <div class="col-3">
                            <g:if test="${item.user.photo}">
                                <g:img dir="images" file="${item.user.photo.substring(25)}" style="border: 2px solid black;border-radius: 10px" margin-left= "20px" margin-right="20px" height="70px" width="70px"/>
                            </g:if>
                            <g:else>
                                <img src="${resource(dir: 'images', file: 'defaultImage.png')}" style="border: 2px solid black;border-radius: 10px" margin-left= "20px" margin-right="20px" height="70px" width="70px"alt="Example Image">
                            </g:else>
                        </div>
                        <div class="col-9">
                            <div class="row">
                                <div class="col-4">
                                    <h5>${item.user.firstname}</h5>
                                </div>
                                <div class="col-4">
                                    <h5>${item.user.username}</h5>
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
                    <hr>
                </g:each>
            </div>
        </div>
        <div class="sidebar-right">
            <div class="login-form">
                <h2>Login</h2>
                <g:form controller="authentication" action="loginUser">
                    <label for="email" >Email/Username:</label>
                    <input type="text" id="email" name="email" required>
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                    <div class="form-links">
                        <input type="submit" style="margin-left:450px" value="Login">
                    </div>
                </g:form>
                <div>
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#forgotPassword" data-bs-whatever="@mdo" >Forgot Password?</button>

                    <div class="modal fade" id="forgotPassword" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalLabel2">Enter email to reset your password</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <g:form controller="authentication" action="forgotPassword">
                                        <div class="mb-3">
                                            <label for="userEmail" class="col-form-label">Enter Email</label>
                                            <g:field name="userEmail" type="email" class="form-control" id="userEmail" required="true" />
                                        </div>

                                        <div class="modal-footer">
                                            <g:submitButton name="Submit" class="btn btn-dark">Submit</g:submitButton>
                                        </div>
                                    </g:form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="register-form">
                <h2>Register</h2>
                <g:uploadForm controller="authentication" action="registerUser">
                    <label for="firstname">First Name:</label>
                    <input type="text" id="firstname" name="firstname" required pattern="[A-Za-z]{3,}">
                    <label for="lastname">Last Name:</label>
                    <input type="text" id="lastname" name="lastname" required pattern="[A-Za-z]{3,}">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required
                           title="please enter valid email">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" required minlength="5">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required  pattern="^[^\s]{8,}$"
                           title="Must contain at least 8 or more characters">
                    <label for="confirmpassword">Confirm Password:</label>
                    <input type="password" id="confirmpassword" name="confirmpassword" required  pattern="^[^\s]{8,}$"
                           title="Must contain at least 8 or more characters">
                    <label for="photo">Photo:</label>
                    <input type="file" id="photo" name="photo">
                    <input type="submit" value="Register" style = "width: 150px;margin-left: 225px;">
                </g:uploadForm>
            </div>
        </div>
    </main>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.0/js/bootstrap.min.js" integrity="sha512-Lep9DTd7VnZv5+Z49WJ5d5ezh7ePc58t8yk/+W1/iXtE+mdtTyCJ0YkYUpI1HlOI0+AWB7FygK6U/gvZUePiHg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/dataTables.bootstrap5.min.js"></script>
    <script>
        $(document).ready(function() {
            $('.topicName').click(function (event){
                $.ajax({
                    url : "/topicShow/index?topicId="+params.topicId, success : function(response){
                        // window.location.reload();
                    }
                });
            });
            $('.topicName2').click(function (event){
                $.ajax({
                    url : "/postShow/index?topicId="+params.topicId, success : function(response){
                        // window.location.reload();
                    }
                });
            });
            $(".timePicker").click(function(event) {
                console.log("timeFrame is clicked");
                var newTimeFrame = this.value;
                console.log("Value selected" + this.value)
                $.ajax({
                    url: "/authentication?timeFrame=" + newTimeFrame,
                    success: function(response) {
                        window.location.replace("/authentication?timeFrame=" + newTimeFrame);
                    }
                });
            });
        });
    </script>

    </body>
    </html>