$(document).ready(function() {
    if(model.flag && model.message){
        console.log(model.flag);
        if(model.flag == "ERROR"){
             $("#password-flag").replaceWith('<div class="alert alert-danger">' + model.message + '</div>');
        } else if (model.flag == "SUCCESS"){
            $("#password-flag").replaceWith('<div class="alert alert-success">' + model.message + '</div>');
        }
    } else {
         $("#password-flag").replaceWith('<div class="hidden"></div>');
    }
});