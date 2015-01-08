window.fullWidthBackground = ->
  css = []
  windowWidth = $(window).width()

  $(".js-full-width-background").each (index) ->
    $(this).addClass "js-full-width-background-#{index}"
    offsetLeft = $(this).offset().left
    css.push ".js-full-width-background-#{index}::before { width: #{windowWidth}px !important; left: -#{offsetLeft}px !important; }"



  jsCssNode = document.getElementById('js-fwbg-p-css')
  jsCssNode.parentNode.removeChild(jsCssNode) if jsCssNode?.parentNode
  css = css.join(' ')
  head = document.head or document.getElementsByTagName("head")[0]
  style = document.createElement("style")
  style.type = "text/css"
  style.id = "js-fwbg-p-css"
  if style.styleSheet
    style.styleSheet.cssText = css
  else
    style.appendChild document.createTextNode(css)
  head.appendChild style
