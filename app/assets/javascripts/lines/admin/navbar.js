$(document).ready(function() {
  // New stuff lines 1.0
  // Handle menu button
  $(document).on("click", ".btn-menu", function(e) {
    $(this).toggleClass("active");
    $("#navbar .submenu").slideToggle(300);
  });

  // Close notification boxes below the navbar
  $('.alert').click(function(e){
    e.preventDefault();
    $(this).slideUp();
  });

});