## *************************************
##
##   JS Complement for Page Layouts
##
## *************************************

# Constants
MEDIUM_SCREEN_SIZE = 700
LARGE_SCREEN_SIZE = 1200
MOBILE_NAV_WIDTH = 230

# -------------------------------------
#   Base Layout
# -------------------------------------

if true

  # ----- Page Elements ----- #

  # add dimmer
  bodyDimmer = document.getElementById('body-dimmer')
  bodyDimmer?.parentNode?.removeChild(jsCssNode)
  bodyDimmer = document.createElement("div")
  bodyDimmer.id = "body-dimmer"
  document.body?.appendChild bodyDimmer

  $bodyDimmer = $('#body-dimmer')

# -------------------------------------
#   Application Layout
# -------------------------------------

$app = $('.app')
if $app.length

  # ----- Page Elements ----- #
  $appNav = $('#app-nav')
  $siteNav = $('#site-nav')

  # check if the page has a App Menu
  if $app.children('.app-menu')?.children()?.children()?.length
    $app.addClass 'has-app-menu'

  # ----- Mobile Nav ----- #

  # add touch trigger
  touchTrigger = document.getElementById('app-nav-touch-trigger')
  touchTrigger?.parentNode?.removeChild(jsCssNode)
  touchTrigger = document.createElement("div")
  touchTrigger.id = "app-nav-touch-trigger"
  document.body?.appendChild touchTrigger
  touchTrigger = document.getElementById('site-nav-touch-trigger')
  touchTrigger?.parentNode?.removeChild(jsCssNode)
  touchTrigger = document.createElement("div")
  touchTrigger.id = "site-nav-touch-trigger"
  document.body?.appendChild touchTrigger

  mobileNavSwipePrevPhase = ''
  mobileNavSwipeStartTime = Date.now()

  mobileNavSwipe = (event, phase, direction, distance) ->
    if phase == 'move'
      mobileNavSwipeStartTime = Date.now() if mobileNavSwipePrevPhase != 'move'
      px = distance
      distance = 0 if direction == 'up' or direction == 'down'
      px = px * -1 if direction == 'left'
      px = px + MOBILE_NAV_WIDTH if $('body').hasClass('is-app-nav-active')
      px = MOBILE_NAV_WIDTH * 1.2 if px > MOBILE_NAV_WIDTH * 1.2
      swipeRate = (MOBILE_NAV_WIDTH-px)/MOBILE_NAV_WIDTH
      $(this).css
        "width": "100%"
      $appNav.css
        "-webkit-transition-property": "none"
        "-moz-transition-property": "none"
        "-o-transition-property": "none"
        "transition-property": "none"
        "-webkit-transition-duration": "0"
        "-moz-transition-duration": "0"
        "-o-transition-duration": "0"
        "transition-duration": "0"
        "-webkit-transform": "translateX(#{px}px)"
        "-webkit-transform": "translateX(#{px}px)"
        "-moz-transform": "translateX(#{px}px)"
        "-ms-transform": "translateX(#{px}px)"
        "-o-transform": "translateX(#{px}px)"
        "transform": "translateX(#{px}px)"
      $bodyDimmer.css
        "-webkit-transition-property": "none"
        "-moz-transition-property": "none"
        "-o-transition-property": "none"
        "transition-property": "none"
        "-webkit-transition-duration": "0"
        "-moz-transition-duration": "0"
        "-o-transition-duration": "0"
        "transition-duration": "0"
        "opacity": "#{0.5 - 0.5*swipeRate}"
      # $siteNav.css
      #   "-webkit-transition-property": "none"
      #   "-moz-transition-property": "none"
      #   "-o-transition-property": "none"
      #   "transition-property": "none"
      #   "-webkit-transition-duration": "0"
      #   "-moz-transition-duration": "0"
      #   "-o-transition-duration": "0"
      #   "transition-duration": "0"
      #   "-webkit-transform": "translateX(#{4-swipeRate*4}px)"
      #   "-webkit-transform": "translateX(#{4-swipeRate*4}px)"
      #   "-moz-transform": "translateX(#{4-swipeRate*4}px)"
      #   "-ms-transform": "translateX(#{4-swipeRate*4}px)"
      #   "-o-transform": "translateX(#{4-swipeRate*4}px)"
      #   "transform": "translateX(#{4-swipeRate*4}px)"
      mobileNavSwipePrevPhase = 'move'
    else if phase == 'end'
      swipeTime = Date.now() - mobileNavSwipeStartTime
      if distance > 20 or swipeTime < 100
        if direction == 'left'
          $('body').removeClass('is-app-nav-active')
        if direction == 'right'
          $('body').addClass('is-app-nav-active')
      $appNav.attr('style', '')
      $siteNav.attr('style', '')
      $bodyDimmer.attr('style', '')
      $(this).attr('style', '')
      mobileNavSwipePrevPhase = 'end'
    else
      $appNav.attr('style', '')
      $siteNav.attr('style', '')
      $bodyDimmer.attr('style', '')
      $(this).attr('style', '')
      mobileNavSwipePrevPhase = ''

  $("#app-nav-touch-trigger").swipe
    swipeStatus: mobileNavSwipe
    allowPageScroll: "vertical"
    threshold: 10

  siteNavSwipePrevPhase = ''
  siteNavSwipeStartTime = Date.now()

  siteNavSwipe = (event, phase, direction, distance) ->
    if phase == 'move'
      siteNavSwipeStartTime = Date.now() if siteNavSwipePrevPhase != 'move'
      px = distance
      distance = 0 if direction == 'up' or direction == 'down'
      px = px * -1 if direction == 'left'
      px = px + MOBILE_NAV_WIDTH if $('body').hasClass('is-site-nav-active')
      px = MOBILE_NAV_WIDTH * 1.2 if px > MOBILE_NAV_WIDTH * 1.2
      $(this).css
        "width": "100%"
      $siteNav.css
        "-webkit-transition-property": "none"
        "-moz-transition-property": "none"
        "-o-transition-property": "none"
        "transition-property": "none"
        "-webkit-transition-duration": "0"
        "-moz-transition-duration": "0"
        "-o-transition-duration": "0"
        "transition-duration": "0"
        "-webkit-transform": "translateX(#{px}px)"
        "-webkit-transform": "translateX(#{px}px)"
        "-moz-transform": "translateX(#{px}px)"
        "-ms-transform": "translateX(#{px}px)"
        "-o-transform": "translateX(#{px}px)"
        "transform": "translateX(#{px}px)"
      siteNavSwipePrevPhase = 'move'
    else if phase == 'end'
      swipeTime = Date.now() - siteNavSwipeStartTime
      if distance > 20 or swipeTime < 100
        if direction == 'left'
          $('body').removeClass('is-site-nav-active')
        if direction == 'right'
          $('body').addClass('is-site-nav-active')
      $siteNav.attr('style', '')
      $bodyDimmer.attr('style', '')
      $(this).attr('style', '')
      siteNavSwipePrevPhase = 'end'
    else
      $siteNav.attr('style', '')
      $bodyDimmer.attr('style', '')
      $(this).attr('style', '')
      siteNavSwipePrevPhase = ''

  $("#site-nav-touch-trigger").swipe
    swipeStatus: siteNavSwipe
    allowPageScroll: "vertical"
    threshold: 10

  $('#body-dimmer').click ->
    $('body').removeClass('is-app-nav-active')
    $('body').removeClass('is-site-nav-active')

  # move
  # moveAppNavDom = ->
  #   if $(window).width() > MEDIUM_SCREEN_SIZE
  #     $("body > #app-nav")?.detach().insertBefore(".main")
  #   else
  #     $(".app > #app-nav")?.detach().insertBefore("#wrapper")
  # moveAppNavDom()

  # $(window).resize ->
  #   moveAppNavDom()
