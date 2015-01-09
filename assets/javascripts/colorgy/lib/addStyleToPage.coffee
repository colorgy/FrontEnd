window.addStyleToPage = (css, id) ->
  css = css.join(' ') unless (typeof css == 'string')
  jsCssNode = document.getElementById(id)
  jsCssNode.parentNode.removeChild(jsCssNode) if jsCssNode?.parentNode
  head = document.head or document.getElementsByTagName("head")[0]
  style = document.createElement("style")
  style.type = "text/css"
  style.id = id
  if style.styleSheet
    style.styleSheet.cssText = css
  else
    style.appendChild document.createTextNode(css)
  head.appendChild style

window.removeStyleFromPage = (id) ->
  jsCssNode = document.getElementById(id)
  jsCssNode.parentNode.removeChild(jsCssNode) if jsCssNode?.parentNode
