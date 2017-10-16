//= require jquery
//= require jquery_ujs
//= require jquery-ui/widgets/datepicker
//= require autocomplete-rails
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require lines/admin/pictures
//= require lines/admin/autosize.min
//= require lines/admin/navbar

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

// Handle Attachment Upload
attachment = {
  init: function() {
    if ($('#article_document').length > 0) {
      this.bind_events();
    }
  },

  bind_events: function() {
    $(document).on('click', '.btn-delete-attachment', function(e) {
      e.preventDefault();
      $(this).remove();
      $('#article_remove_document').prop('checked', true);
      $('.attachment-label').html('Attach Document');
    });

    document.getElementById('article_document').addEventListener('change', this.preview, false);
  },

  preview: function(e) {
    var files = e.target.files;
    if (files.length > 0) {
      var f = files[0];
      label = f.name + ' <span>(' + Math.round((f.size / 1000000) * 100) / 100 + 'MB)</span>';
      $('.attachment-label').html(label);
      $('.btn-delete-attachment').remove();
      $('#article_remove_document').prop('checked', false);
      $('.attachment-label').after('<span class="icon-delete btn-delete-attachment" title="Remove Attachment"></span>');
    }
  }
};

// Handle Hero Image Uploads / Selection / Preview
hero_image = {
  init: function() {
    if ($('#article_hero_image').length > 0) {
      this.bind_events();
      this.check_availability();
    }
  },

  bind_events: function() {
    $(document).on('click', '.btn-change-hero', function(e) {
      e.preventDefault();
      $('.upload-overlay').fadeIn('fast');
      $('body').addClass('no-scroll');
    });
    $(document).on('click', '.hero-background-overlay, .upload-overlay-close', function(e) {
      e.preventDefault();
      $('.upload-overlay').fadeOut('fast');
      $('body').removeClass('no-scroll');
    });
    $(document).on('click', '.hero-images img', function(e) {
      e.preventDefault();
      hero_image.preview_default($(this));
    });
    $(document).on('click', '.btn-remove-hero', function(e) {
      e.preventDefault();
      hero_image.remove_hero();
    });
    document.getElementById('article_hero_image').addEventListener('change', this.preview, false);
  },

  check_availability: function() {
    if (!window.File && !window.FileReader && !window.FileList && !window.Blob) {
      console.log('The File APIs are not fully supported in this browser.');
    }
  },

  remove_hero: function() {
    $('#article_short_hero_image, #article_hero_image_file').val('');
    upload_field = $('#article_hero_image')
    upload_field.wrap('<form>').closest('form').get(0).reset();
    upload_field.unwrap();
    $('#article_remove_hero_image').val('true');
    $('.hero-upload > img').remove();
    $('.upload-overlay').fadeOut('fast');
    $('body').removeClass('no-scroll');
    $('.btn-remove-hero').removeClass('show')
  },

  preview_default: function(img) {
    $('#article_hero_image_file').val('');
    $('#article_remove_hero_image').val('');
    $('#article_short_hero_image').val(img.attr('src'));
    if ($('.hero-upload > img').length) {
      $('.hero-upload > img').attr('src', img.attr('src'));
    } else {
      $('.hero-upload').append('<img src="' + img.attr('src') + '" alt="" />');
    }
    $('.btn-remove-hero').addClass('show');
    $('.upload-overlay').fadeOut('fast');
    $('body').removeClass('no-scroll');
  },

  preview: function(e) {
    var files = e.target.files;
    if (files.length > 0) {
      var f = files[0];
      var reader = new FileReader();
      reader.onload = (function(theFile) {
        return function(e) {
          $('#article_short_hero_image').val('');
          $('#article_remove_hero_image').val('');
          if ($('.hero-upload > img').length) {
            $('.hero-upload > img').attr('src', e.target.result);
          } else {
            $('.hero-upload').append('<img src="' + e.target.result + '" alt="" />');
          }
          $('.btn-remove-hero').addClass('show');
          $('.upload-overlay').fadeOut('fast');
          $('body').removeClass('no-scroll');
        };
      })(f);
      reader.readAsDataURL(f);
    }
  }
};

// Handle Copy Editor
editor = function(el) {
  // Initialize CodeMirror Instance
  this.cm = CodeMirror.fromTextArea(el, {
    mode: {
      name: 'gfm',
      highlightFormatting: true
    },
    lineWrapping: true,
    styleActiveLine: true,
    tabSize: 2,
    theme: 'lines',
    viewportMargin: Infinity
  });

  this.wrapper = $(this.cm.getTextArea()).parent();

  // Create and inset moving widget before editor
  this.movingWidget = $('<div class="cm-movingwidget icon-add-image"></div>');
  $(el).before(this.movingWidget);

  // Save `this` for usage inside child-functions
  obj = this

  // Initialize Moving Widget
  init_moving_widget = function() {
    if (obj.movingWidget) {
      obj.cm.on('cursorActivity', function() {
        setTimeout(function() {
          var al = obj.wrapper.find('.CodeMirror-activeline');

          if (al.length) {
            obj.movingWidget.show()
            obj.movingWidget.css({
              'top': (al.offset().top - obj.wrapper.offset().top) + 'px'
            });
          } else {
            obj.movingWidget.hide();
          }
        });
      });
    }
  }();

  // Bind events
  bind_events = function() {
    // Moving Widget Click Event Listener
    obj.movingWidget.on('click', function() {
      $('.images-overlay').fadeIn('fast');
      $('body').addClass('no-scroll');
    });

    // Close images overlay
    $(document).on('click', '.images-background-overlay, .images-overlay-close', function() {
      $('.images-overlay').fadeOut('fast');
      $('body').removeClass('no-scroll');
    });

    // Insert image to content
    $(document).on('click', '.image-preview', function() {
      $('.images-overlay').fadeOut('fast');
      $('body').removeClass('no-scroll');
      obj.cm.replaceSelection('\n![Alt Text](' + $(this).data('url') + ')\n');
      obj.cm.focus();
    });
    $(document).on('click', '.image-preview *', function(e) {
      e.stopPropagation();
    });
  }();
};

$(document).ready(function() {
  // New stuff lines 1.0
  // Handle hero image uploads
  hero_image.init();

  // Handle document attachments
  attachment.init();

  // Handle Codemirror
  $.each($("[data-editor='codemirror']"), function(key, val) {
    new editor(val);
  });

  // ---------------------------------------------------------

  // Deactivate OnBeforeUnload on submit button
  // You can add even more buttons, just add the class or id of the button/link
  // All buttons/links which are listed below will not produce a "Warning"-Alert on leaving the page when something has changed but not saved
  $('.btn-save-publish').click(function() {
    window.onbeforeunload = null;
  });

  // Autogrow and -shrink the content text box while typing
  // This allows the user to see the whole text copy all the time
  $('textarea').autosize();

  // Close error notification
  $('#error_explanation, .close').on('click', function(e){
    $('#error_explanation').slideUp();
  });
  
  // Insert image into content of the post
  // $(document.body).on('click', ".insert-image",  function(e){
  //   var url = $(this).attr( 'data-url' );
  //   var value = '\n![Alt text](' + url + ')\n';
  //   $('#article_content').insertAtCaret(value);
  //   e.preventDefault();
  // });

  // Show datepicker
  $(document).on("focus", "[data-behaviour~='datepicker']", function(e){
    var altFormat = $(this).datepicker( "option", "altFormat" );
    $(this).datepicker({dateFormat: "yy-mm-dd"});
  });

  // Scroll to the top of the page
  // $('.top_link').click(function(){
  //   $("html, body").animate({ scrollTop: 0 }, 600);
  //   return false;
  // });

  // Formatting Help functions
  // $('.btn-close-formatting').click(function() {
  //   $('#formatting_guide').fadeOut();
  // });
  // $('.btn-close-formatting-small').click(function() {
  //   $('#formatting_guide').fadeOut();
  // });
  // $('.btn-formatting-help').click(function() {
  //   $('#formatting_guide').fadeIn();
  // });
  
  // Show security alert on unload only when something has changed
  $('.edit_article input, .edit_article textarea, .new_article input, .new_article textarea').bind("keyup change", function() {
    window.onbeforeunload = function() {
      return 'You have NOT saved your article. Stop and save if you want to keep your changes.';
    };
  });

});
