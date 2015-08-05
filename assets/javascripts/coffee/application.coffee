$(document).ready ->
  app.init()

app =
  init: ->
    lightbox.init()


###
# Lightbox
# Author: Max Boll
# Company: Opoloo
# Website: opoloo.com
###
lightbox =
  init: ->
    lb = $('<div class="lightbox"><img src="" alt="" /></div>')
    $('body').append(lb)
    $('[data-lightbox]').css('cursor', 'pointer')
    @bind_events()

  bind_events: ->
    $(document).on 'click', '[data-lightbox]', (e) ->
      e.preventDefault()
      lightbox.open $(this).data('lightbox')
    $(document).on 'click', '.lightbox', (e) ->
      e.preventDefault()
      $('.lightbox').fadeOut('fast')

  open: (image_url) ->
    img = new Image()
    img.src = image_url
    $('.lightbox img').attr('src', image_url)
    img.onload = ->
      iw = this.width
      ih = this.height
      vw = $(window).width()
      vh = $(window).height()
      new_ih = ih / iw * vw
      if new_ih > vh
        # Fit height
        $('.lightbox').removeClass('landscape').addClass('portrait')
      else
        # Fit width
        $('.lightbox').removeClass('portrait').addClass('landscape')
      $('.lightbox').fadeIn('fast')