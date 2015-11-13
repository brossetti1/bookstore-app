$(document).ready(function() {
  if($(location).attr('pathname') === '/orders/new') {
    $("#clear-cart-btn, #checkout-btn").hide();
  }
});
