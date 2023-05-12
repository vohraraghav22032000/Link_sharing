var exampleModal = document.getElementById('exampleModal')
exampleModal.addEventListener('show.bs.modal', function (event) {
    // Button that triggered the modal
    var button = event.relatedTarget
    // Extract info from data-bs-* attributes
    var recipient = button.getAttribute('data-bs-whatever')
    // If necessary, you could initiate an AJAX request here
    // and then do the updating in a callback.
    //
    // Update the modal's content.
    var modalTitle = exampleModal.querySelector('.modal-title')
    var modalBodyInput = exampleModal.querySelector('.modal-body input')

    modalTitle.textContent = 'New message to ' + recipient
    modalBodyInput.value = recipient
})



// function ajaxCall(){
//     $.ajax(){
//         {
//             type: "GET",
//                 url: WebApiURL + ".....URL...." + departCode,
//             dataType: "json",
//             crossDomain: true,
//             async: true,
//             cache: false,
//             success: function (data) {
//             var srno = 1;
//             $('#tblPendingHrResponse').find($('.trTblPendingHrResponse')).remove();
//
//             $.each(data.data, function (index, value) {
//                 random(value, srno);
//                 srno++;
//             });
//         },
//             error: function (x, e) {
//                 alert('There seems to be some problem while fetching records!');
//             }
//
//         }
//     }
// }