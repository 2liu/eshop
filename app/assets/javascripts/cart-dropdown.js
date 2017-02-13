function minicart_show(id) {
    document.getElementById(id).style.visibility = "visible";
}

function minicart_hide(id) {
  document.getElementById(id).style.visibility = "hidden";
}



$(document).ready(function(){
    $(".mycart").hover(function(){
        $("#cart-dropdown").css("display", "block");
    }, function(){
        $("#cart-dropdown").css("display", "none");
    });
});
