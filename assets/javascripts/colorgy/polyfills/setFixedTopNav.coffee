window.setFixedTopNav = ->
  css = []
  winScrollTop = $(window).scrollTop()
  if winScrollTop
    css.push "body.snapjs-left .site-banner { position: absolute !important; top: #{winScrollTop}px !important; }"
    css.push "body.snapjs-left .app-logo { position: absolute !important; top: #{winScrollTop}px !important; left: 0px !important; }"
    css.push "body.snapjs-left .app-menu { position: absolute !important; top: #{winScrollTop}px !important; left: 0px !important; }"
    css.push "body.snapjs-left .has-app-menu .app-logo { display: none !important; }"

  jsCssNode = document.getElementById('js-setFixedTopNav-css')
  jsCssNode.parentNode.removeChild(jsCssNode) if jsCssNode?.parentNode
  css = css.join(' ')
  head = document.head or document.getElementsByTagName("head")[0]
  style = document.createElement("style")
  style.type = "text/css"
  style.id = "js-setFixedTopNav-css"
  if style.styleSheet
    style.styleSheet.cssText = css
  else
    style.appendChild document.createTextNode(css)
  head.appendChild style

setFixedTopNav()

$(window).scroll ->
  if window.appSnapper?.state()?.state != 'closed'
    setFixedTopNav()
  else
    waitForFinalEvent (->
        setFixedTopNav()
        $('.js-sticky').Stickyfill()
      ), 50, "setFixedTopNav"

