$(document).ready(function() {
    if(cartItems){
        if(cartItems.length > 2){
            //cartItems is initialized to 2??
            $("#view-cart-anchor").addClass("btn secondary_color");
            $("#view-cart-span").text("View Cart");
        }
    }
});