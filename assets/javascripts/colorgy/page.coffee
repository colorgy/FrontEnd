mediumScreenSize = 700
largeScreenSize = 1200

appSnapperSettings =
  # element: null
  # dragger: null
  disable: "right"
  addBodyClasses: true
  hyperextensible: true
  resistance: 0.5
  flickThreshold: 50
  transitionSpeed: 0.3
  easing: "ease"
  maxPosition: 200
  tapToClose: true
  touchToDrag: true
  slideIntent: 40
  minDragDistance: 5

window.appSnapper = new Snap(element: document.getElementById("wrapper"))
window.appSnapper.settings(appSnapperSettings)

$app = $('.app')
if $app.length
  if $app.children('.app-menu')?.children()?.children()?.length
    $app.addClass 'has-app-menu'

moveAppNavDom = ->
  if $(window).width() > mediumScreenSize
    $("body > #app-nav")?.detach().insertBefore(".main")
  else
    $(".app > #app-nav")?.detach().insertBefore("#wrapper")
moveAppNavDom()

$(window).resize ->
  moveAppNavDom()
