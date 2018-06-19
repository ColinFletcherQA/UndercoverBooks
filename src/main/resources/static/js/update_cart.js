function calculateTotalPrice(price, quantity, old, price_label) {
    console.log(old + " " + quantity);

	var cartTotal = document.getElementById("cart_total").value;
	var orderTotal = document.getElementById("order_total").value;
	var totalPrice = (parseFloat(price) * parseFloat(quantity)).toFixed(2);

	price_label.innerHTML = "$" + totalPrice;

	if (quantity > old) {
        cTotal = (parseFloat(cartTotal) + parseFloat(price)).toFixed(2);
        oTotal = (parseFloat(orderTotal) + parseFloat(price)).toFixed(2);
    } else {
        cTotal = (parseFloat(cartTotal) - parseFloat(price)).toFixed(2);
        oTotal = (parseFloat(orderTotal) - parseFloat(price)).toFixed(2);
    }
	       
	document.getElementById("cart_total_label").innerHTML = "$" + cTotal;
	document.getElementById("order_total_label").innerHTML = "$" + oTotal;
	document.getElementById("cart_total").value = cTotal;
	document.getElementById("order_total").value = oTotal;
}
	
