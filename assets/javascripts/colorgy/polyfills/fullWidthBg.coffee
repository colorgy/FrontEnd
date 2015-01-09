window.fullWidthBackground = ->
  css = []
  windowWidth = $(window).width()
  wrapperOffset = $('#wrapper')?.offset()?.left or 0

  $(".js-full-width-background").each (index) ->
    $(this).addClass "js-full-width-background-#{index}"
    offsetLeft = $(this).offset().left - wrapperOffset
    css.push ".js-full-width-background-#{index}::before { width: #{windowWidth}px !important; left: -#{offsetLeft}px !important; }"

  addStyleToPage(css, 'js-fwbg-p-css')
