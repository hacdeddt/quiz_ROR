$ ->
  if $('.pagination').length && $('#qbanks').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 80
        $('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." /><span style="color: #2f6cc8;"> Loading more...</span>')
        $.getScript(url)
    $(window).scroll()