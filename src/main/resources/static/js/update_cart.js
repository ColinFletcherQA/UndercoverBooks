function increaseQuantity(price, price_label, quantity_label) {
    price = parseFloat(price);

    var cartTotal = parseFloat(document.getElementById("cart_total").value);
    var quantity = parseInt(quantity_label.textContent) + 1;
    var totalPrice = price * quantity;

    price_label.innerHTML = "Price: $" + totalPrice.toFixed(2).toString();
    quantity_label.innerHTML = quantity.toString();

    var cTotal = cartTotal + price;
    var tax = cTotal * 0.08;
    var oTotal = (cTotal + tax).toFixed(2);

    tax = tax.toFixed(2);
    cTotal = cTotal.toFixed(2);

    document.getElementById("cart_tax_label").innerHTML = "$" + tax;
    document.getElementById("cart_total_label").innerHTML = "$" + cTotal;
    document.getElementById("order_total_label").innerHTML = "$" + oTotal;
    document.getElementById("cart_tax").value = tax;
    document.getElementById("cart_total").value = cTotal;
    document.getElementById("order_total").value = oTotal;
}

function decreaseQuantity(price, price_label, quantity_label) {
    var quantity = parseInt(quantity_label.textContent) - 1;

    if (quantity === 0) {
        return;
    }

    price = parseFloat(price);

    var cartTotal = parseFloat(document.getElementById("cart_total").value);
    var totalPrice = price * quantity;

    price_label.innerHTML = "Price: $" + totalPrice.toFixed(2).toString();
    quantity_label.innerHTML = quantity.toString();

    var cTotal = cartTotal - price;
    var tax = cTotal * 0.08;
    var oTotal = (cTotal + tax).toFixed(2);

    tax = tax.toFixed(2);
    cTotal = cTotal.toFixed(2);

    document.getElementById("cart_tax_label").innerHTML = "$" + tax;
    document.getElementById("cart_total_label").innerHTML = "$" + cTotal;
    document.getElementById("order_total_label").innerHTML = "$" + oTotal;
    document.getElementById("cart_tax").value = tax;
    document.getElementById("cart_total").value = cTotal;
    document.getElementById("order_total").value = oTotal;
}
