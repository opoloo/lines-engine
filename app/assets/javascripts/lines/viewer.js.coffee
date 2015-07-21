jQuery ->
  $('.article .article_content p img').each (image) ->
    $(this).parent().css('padding', '0')