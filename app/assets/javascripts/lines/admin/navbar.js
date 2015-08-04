navbar = {
  init: function() {
    this.bind_events();
  },

  bind_events: function() {
    // Handle menu button
    $(document).on('click', '.btn-menu', function(e) {
      navbar.toggle_navbar();
    });
  },

  toggle_navbar: function() {
    $('.btn-menu').toggleClass('active');
    $('#navbar .submenu').slideToggle(300);
  }
};

cheatsheet = {
  init: function() {
    this.bind_events();
  },

  bind_events: function() {
    $(document).on('click', '.cheatsheet-overlay, .cheatsheet-close', function(e) {
      e.preventDefault();
      $('.cheatsheet').fadeOut('fast');
      $('body').removeClass('no-scroll');
    });

    $(document).on('click', '.btn-cheatsheet', function(e) {
      e.preventDefault();
      navbar.toggle_navbar();
      $('.cheatsheet').fadeIn('fast');
      $('body').addClass('no-scroll');
    });
  }
};

$(document).ready(function() {
  // New stuff lines 1.0
  navbar.init();

  cheatsheet.init();

  // Close notification boxes below the navbar
  $('.alert').click(function(e){
    e.preventDefault();
    $(this).slideUp();
  });
});