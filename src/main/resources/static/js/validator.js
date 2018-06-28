$(document).ready(function() {

    $("form").each(function(){
        var form = $(this);

        form.submit(function(event){
            var valid = true;

            form.find("input").each(function(){
                var input = $(this);
                var inputType = input.attr('type');

                if(input.css('display') != 'none'){
                    if(inputType == 'text' || inputType == 'email' || inputType == 'password'){

                        if(input.attr('name') != 'addressLine2'){
                            if(!input.val()){
                                input.css('border', '3px solid red');
                                valid = false;
                            } else {
                                input.css('border-color', '');
                            }
                        }
                    } else if (inputType == 'tel' && input.attr('name') != "cardNumber" && input.attr("name") != "postcode"){
                        if(input.val().length != 10){
                            input.css('border', '3px solid red');
                            valid = false;
                        } else {
                            input.css('border-color', '');
                        }
                    }
                }
            });
            return valid;
        });
    });
});

