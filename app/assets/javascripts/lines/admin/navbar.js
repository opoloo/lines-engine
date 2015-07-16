$(document).ready(function() {
  // New stuff lines 1.0
  // Handle menu button
  $(document).on("click", ".btn-menu", function(e) {
    $(this).toggleClass("active");
    $("#navbar .submenu").slideToggle(300);
  });

});