<%--
  Created by IntelliJ IDEA.
  User: raghavvohra
  Date: 21/06/23
  Time: 2:43 PM
--%><%--
  Created by IntelliJ IDEA.
  User: raghavvohra
  Date: 16/06/23
  Time: 6:14 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Password Reset Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.0/css/bootstrap.min.css" integrity="sha512-CpPbEViCJZw1fQr1qUn6Tjs9ePavU6J4Q4Oq3UXqKj/4G/teysvOuS7a/zN9rxuK7VgOvbu0lBh8Zdi5ox5+Lw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'homePage.css')}">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.0/js/bootstrap.min.js" integrity="sha512-Lep9DTd7VnZv5+Z49WJ5d5ezh7ePc58t8yk/+W1/iXtE+mdtTyCJ0YkYUpI1HlOI0+AWB7FygK6U/gvZUePiHg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/dataTables.bootstrap5.min.js"></script>

    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'flashMessage.css')}">

</head>

<body>

<g:if test="${flash.successMessage}">

    <div id="success-message" class="alert alert-success toast show position-fixed top-0 start-50 translate-middle-x" style="z-index: 9999; background-color: darkgrey;">
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

<h1 style="margin:20px;background: cyan;border-radius: 10px;padding-left: 350px">Please enter your new password</h1>
<div class="login-form" style="margin: 60px;background: orange;width:400px;margin-left: 450px">

    <g:form name = "updateForm" controller="register" action="updatePasswordUsingLink">
        <label for="email" >Email</label>
        <input type="text" id="email" name="email" required>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required pattern="^[^\s]{8,}$"
               title="Password Must contain at least 8 or more characters">
        <label for="confirmpassword">Confirm Password:</label>
        <input type="password" id="confirmpassword" name="confirmpassword" required pattern="^[^\s]{8,}$"
               title="Password must contain at least 8 or more characters">
        <input type="submit" value="Update" style = "width: 150px;margin-left: 120px;">
    </g:form>
</div>

</body>
</html>