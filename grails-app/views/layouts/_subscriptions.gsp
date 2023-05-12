<g:each in="${subscriptionList}" var="item">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <img src="${resource(dir: 'images', file: 'defaultImage.png')}" alt="Example Image">
            </div>
            <div class="col-md-8">
                <h4>${user.firstname} ${user.lastname}</h4>
                <p><strong>Subscriptions:</strong>${subscriptionList.size()}</p>
                <p><strong>Topics:</strong>${topicCount}</p>
            </div>
        </div>
    </div>
    <div class="my-section d-flex justify-content-between align-items-center">
        <div>
            <select id="selectPicker1" name="${item.seriousness}" class="form-select form-select-lg mb-3" aria-label=".form-select-lg example">
                <option selected>${item.seriousness}</option>
%{--                <option value="public">Public</option>--}%
%{--                <option value="private">Private</option>--}%

            </select>
        </div>

        <div>
            <select id="selectPicker1" name="${item.topic.visibility}" class="form-select form-select-lg mb-3" aria-label=".form-select-lg example">
                <option selected>${item.topic.visibility}</option>
                <option value="public">Public</option>
                <option value="private">Private</option>
            </select>
        </div>

        <div>
            %{--                <i class="bi bi-chat-right-dots"></i>--}%
            %{--            <li class="nav-item">--}%
            %{--                <a class="nav-link disabled" href="#">Send Invitation</a>--}%
            %{--            </li>--}%

            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal2" data-bs-whatever="@mdo" style="margin-right: 20px; margin-left:20px"><i class="bi bi-chat-right-dots"></i></button>

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
                                    <label for="message-text" class="col-form-label">Choose topic</label>
                                    <select name="topic" class="form-select form-select-lg mb-3" aria-label=".form-select-lg example">
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
        <button type="button" class="btn btn-success"><i class="bi bi-pencil-square"></i></button>
        <button type="button" class="btn btn-danger"><i class="bi bi-trash3-fill"></i></button>
    </div>
    <br />
%{--    <br style="{--}%
%{--    background-color: #333;--}%
%{--    color: #fff;--}%
%{--    padding: 5px;--}%
%{--    border-radius: 5px;--}%
%{--    }--}%
%{--    ">--}%
</g:each>

