//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require autocomplete-rails
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require pictures
//= require autosize.min

// Function to insert uploaded pictures into the content at cursor position
jQuery.fn.extend({
  insertAtCaret: function(myValue){
    return this.each(function(i) {
      if (document.selection) {
        //For browsers like Internet Explorer
        this.focus();
        sel = document.selection.createRange();
        sel.text = myValue;
        this.focus();
      }
      else if (this.selectionStart || this.selectionStart == '0') {
        //For browsers like Firefox and Webkit based
        var startPos = this.selectionStart;
        var endPos = this.selectionEnd;
        var scrollTop = this.scrollTop;
        this.value = this.value.substring(0, startPos)+myValue+this.value.substring(endPos,this.value.length);
        this.focus();
        this.selectionStart = startPos + myValue.length;
        this.selectionEnd = startPos + myValue.length;
        this.scrollTop = scrollTop;
      } else {
        this.value += myValue;
        this.focus();
      }
    });
  }
});

$(document).ready(function() {
  // Deactivate OnBeforeUnload on submit button
  // You can add even more buttons, just add the class or id of the button/link
  // All buttons/links which are listed below will not produce a "Warning"-Alert on leaving the page when something has changed but not saved
  $('.btn-save-publish').click(function() {
    window.onbeforeunload = null;
  });

  // Autogrow and -shrink the content text box while typing
  // This allows the user to see the whole text copy all the time
  $('#article_content').autosize();

  // Close error notification
  $('#error_explanation, .close').on('click', function(e){
    $('#error_explanation').slideUp();
  });
  
  // Insert image into content of the post
  $(".insert-image").live('click', function(e){
    var url = $(this).attr( 'data-url' );
    var value = '\n![Alt text](' + url + ')\n';
    $('#article_content').insertAtCaret(value);
    e.preventDefault();
  });

  // Show datepicker
  $(document).on("focus", "[data-behaviour~='datepicker']", function(e){
    var altFormat = $(this).datepicker( "option", "altFormat" );
    $(this).datepicker({dateFormat: "yy-mm-dd"});
  });

  // Select a default hero image
  // Switch classes and preview the selected default image in the hero image canvas
  $(".select_image").live('click', function(e){
    e.preventDefault();
    
    bg_url = $(this).attr('src');
    
    $('.hero-image').css('background-image', 'url(' + bg_url + ')');
    
    if ($(this).hasClass('selected_image')) { // deselect selected short_hero image
      $(".selected_image").removeClass('selected_image');
      $("#article_short_hero_image, #article_hero_image_file").val('');
    } else if ($(this).hasClass('uploaded_image')) { // select former uploaded hero_image
      $(".selected_image").removeClass('selected_image');
      //TODO: How to get the selected value?
      $('#article_hero_image, #article_hero_image_cache, #article_short_hero_image').val('');
      $('#article_hero_image_file').val(bg_url);
    } else { // select short_hero_image image
      var value = $(this).attr('src');
      $('#article_hero_image_file, #article_hero_image, #article_hero_image_cache').val('');
      $(".selected_image").removeClass('selected_image');
      $(this).addClass("selected_image");
      $("#article_short_hero_image").val(value);
    }
    $('#hero_image_name').text('');
    $('.choose-file').html("Change Image");
  });

  // Unselect hero image on upload
  // If a custom image is selected of the hard drive, the current selected default image will be unselected
  $('#article_hero_image').on('change', function(e){
    $(".selected_image").removeClass('selected_image');
    $("#article_short_hero_image").val('');
  });

  // Scroll to the top of the page
  $('.top_link').click(function(){
    $("html, body").animate({ scrollTop: 0 }, 600);
    return false;
  });



  // File Reader for hero image and document upload
  // If you need more input fields like this, you need to add an event listener for every input field
  // You also need to insert a case for every input inside of the "handleFiles" function below ($type_id)
  if (window.File && window.FileList && window.FileReader) {
    var hero_input      = document.getElementById('article_hero_image');  // Hero image input
    var document_input  = document.getElementById('article_document');    // Document input
    if (typeof(hero_input) !== 'undefined' && hero_input !== null && typeof(document_input) !== 'undefined' && document_input !== null) {
      hero_input.addEventListener('change', handleFiles, false);          // Add listener to the hero image input
      document_input.addEventListener('change', handleFiles, false);      // Add listener to the document input
    }
  } else {
    alert("You need a browser with file reader support, to use this form properly.");
  }

  // This function handels the hero image & documents
  // It generates a live preview (image/name) of the selected file
  function handleFiles(event) {
    var files   = event.target.files;       // Get current file
    var type_id = event.currentTarget.id;   // Get the # of the current input field

    if (files.length > 0) {
      var file = files[0];
      var reader = new FileReader();

      // Check format
      if (type_id == 'article_hero_image') {
        if (!file.type.match('image')) {
          return false;
        }
      } else if (type_id == 'article_document') {
        // Nothing to do here yet ...
      }

      // Load file
      reader.addEventListener("load",function(event) {
        var loadedFile = event.target;

        // Change labels, background and so on
        // Different action depending on the type_id
        if (type_id == 'article_hero_image') {
          $('.hero-image').css("background-image","url("+loadedFile.result+")");
          $('.hero-image').css("background-size","cover");

          $('.choose-file').html("Change Image");
          $('.short-hero-images').append("<div class=\"short-hero-image-box\"><img src=\""+loadedFile.result+"\" width=\"115\" class=\"select_image uploaded_image\" /></div>");
        } else if (type_id == 'article_document') {
          $('.choose-files').html(file.name);
        }
      });

      // Read the file
      reader.readAsDataURL(file);
    } else {
      // Change labels, background and so on
      // Different action depending on the type_id
      if (type_id == 'article_hero_image') {
        $('.choose-file').html("Choose Image");
        $('.hero-image').css("background-image","none");
      } else if (type_id == 'article_document') {
        $('.choose-files').html("Choose File");
      }
    }
  }

  // Close notification boxes below the navbar
  $('.alert').click(function(e){
    e.preventDefault();
    $(this).slideUp();
  });

  // Formatting Help functions
  $('.btn-close-formatting').click(function() {
    $('#formatting_guide').fadeOut();
  });
  $('.btn-close-formatting-small').click(function() {
    $('#formatting_guide').fadeOut();
  });
  $('.btn-formatting-help').click(function() {
    $('#formatting_guide').fadeIn();
  });
  
  // Show security alert on unload only when something has changed
  $('.edit_article input, .edit_article textarea, .new_article input, .new_article textarea').bind("keyup change", function() {
    window.onbeforeunload = function() {
      return 'You have NOT saved your article. Stop and save if you want to keep your changes.';
    };
  });

});