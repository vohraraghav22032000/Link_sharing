<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css" integrity="sha384-b6lVK+yci+bfDmaY1u0zE8YYJt0TZxLEAFyYSLHId4xoVvsrQu3INevFKo+Xir8e" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">


</head>
    <body>
        <g:render template="/layouts/navbar" model="[subscriptionList : subscriptionList]"/>
        <div class="container" style="margin-top: 50px">
            <div class="row">
                <div class="col-md-6">
                    <div class="input-group mb-3">
                        <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">Dropdown</button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">Option 1</a></li>
                            <li><a class="dropdown-item" href="#">Option 2</a></li>
                            <li><a class="dropdown-item" href="#">Option 3</a></li>
                        </ul>
                        <input type="text" class="form-control" placeholder="Search" aria-label="Search" aria-describedby="button-addon2">
                        <button class="btn btn-outline-secondary" type="button" id="button-addon2">Search</button>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Active</th>
                            <th>Manage</th>
                        </tr>
                        </thead>
                        <tbody>
                            <g:each in="${allUsers}" var="item">
                                <tr>
                                    <td>item</td>
                                    <td>${item.username}</td>
                                    <td>${item.email}</td>
                                    <td>${item.firstname}</td>
                                    <td>${item.lastname}</td>
                                    <td>Yes</td>
                                    <td>
                                        <button class="btn btn-primary">Activate</button>
                                        <button class="btn btn-danger">Deactivate</button>
                                    </td>
                                </tr>
                            </g:each>
                        <!-- Add more rows here as needed -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
