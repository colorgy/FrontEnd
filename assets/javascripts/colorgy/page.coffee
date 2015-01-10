## *************************************
##
##   JS Complement for Page Layouts
##
## *************************************

# Constants
MEDIUM_SCREEN_SIZE = 800
LARGE_SCREEN_SIZE = 1200
MOBILE_NAV_WIDTH = 230
LOGO_WIDTH = 45
WINDOW_WIDTH = $(window).width()
TOUCH_EVENTS = ['tap','hold', 'swipe','swipeLeft','swipeRight','swipeUp','swipeDown','swipeStatus','pinch','pinchIn','pinchOut','pinchStatus'];

$(window).resize ->
  WINDOW_WIDTH = $(window).width()

onMobile = ->
  WINDOW_WIDTH < MEDIUM_SCREEN_SIZE

onTablet = ->
  WINDOW_WIDTH >= MEDIUM_SCREEN_SIZE and WINDOW_WIDTH < LARGE_SCREEN_SIZE

onTabletUp = ->
  WINDOW_WIDTH >= MEDIUM_SCREEN_SIZE

onDesktop = ->
  WINDOW_WIDTH >= LARGE_SCREEN_SIZE

nullFunction = ->
  false


# -------------------------------------
#   Base Layout
# -------------------------------------

if true

  # ----- Page Elements ----- #

  # add dimmer
  bodyDimmer = document.getElementById('body-dimmer')
  bodyDimmer?.parentNode?.removeChild(bodyDimmer)
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

  appNavWidth = $appNav.width()
  appNavHeight = $appNav.height()
  siteNavHeight = $siteNav.height()
  appNavOffset = $appNav.offset()

  # check if the page has a App Menu
  if $app.children('.app-menu')?.children()?.children()?.length
    $app.addClass 'has-app-menu'

  # add touch trigger
  touchTrigger = document.getElementById('site-nav-touch-trigger')
  touchTrigger?.parentNode?.removeChild(touchTrigger)
  touchTrigger = document.createElement("div")
  touchTrigger.id = "site-nav-touch-trigger"
  document.body?.insertBefore(touchTrigger, document.body.firstChild)
  touchTrigger = document.getElementById('app-nav-touch-trigger')
  touchTrigger?.parentNode?.removeChild(touchTrigger)
  touchTrigger = document.createElement("div")
  touchTrigger.id = "app-nav-touch-trigger"
  document.body?.insertBefore(touchTrigger, document.body.firstChild)

  $siteNavTouchTrigger = $("#site-nav-touch-trigger")
  $appNavTouchTrigger = $("#app-nav-touch-trigger")


  # ----- Register Events ----- #

  # Click Events

  $('.site-banner, .site-banner *').click ->
    if onMobile()
      $('body').toggleClass('is-app-nav-active')
      $('body').removeClass('is-site-nav-active')
      false
    else
      true

  $('.app-logo, .app-logo *').click ->
    if onMobile()
      $('body').toggleClass('is-app-nav-active')
      $('body').removeClass('is-site-nav-active')
      false
    else if onTabletUp() and not $('html').hasClass('no-touch')
      $('body').toggleClass('is-app-nav-active')
      $('body').removeClass('is-site-nav-active')
      false
    else
      true

  $('.app-menu').click (e) ->
    if onMobile() and (e.pageX < LOGO_WIDTH or e.pageX > WINDOW_WIDTH - LOGO_WIDTH )
      $('body').toggleClass('is-app-nav-active')
      $('body').removeClass('is-site-nav-active')
      false
    else
      true

  # Touch Swipe Events

  appNavSwipe = (event, phase, direction, distance, duration, fingers, fingerData) ->
    if onMobile()
      distance = 0 if direction == 'up' or direction == 'down'
      if phase == 'move'
        px = distance
        px = px * -1 if direction == 'left'
        px = px + MOBILE_NAV_WIDTH if $('body').hasClass('is-app-nav-active')
        px = MOBILE_NAV_WIDTH * 1.2 if px > MOBILE_NAV_WIDTH * 1.2
        swipeRate = (MOBILE_NAV_WIDTH-px)/MOBILE_NAV_WIDTH
        $(this).css
          "width": "100%"
          "left": "0"
        $appNav.css
          "-webkit-transition-property": "none"
          "-moz-transition-property": "none"
          "-o-transition-property": "none"
          "transition-property": "none"
          "-webkit-transition-duration": "0"
          "-moz-transition-duration": "0"
          "-o-transition-duration": "0"
          "transition-duration": "0"
          "-webkit-transform": "translateX(#{px}px) scaleY(1)"
          "-moz-transform": "translateX(#{px}px) scaleY(1)"
          "-ms-transform": "translateX(#{px}px) scaleY(1)"
          "-o-transform": "translateX(#{px}px) scaleY(1)"
          "transform": "translateX(#{px}px) scaleY(1)"
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
      else if phase == 'end'
        if distance > 20 or duration < 100
          if direction == 'left'
            $('body').removeClass('is-app-nav-active')
          if direction == 'right'
            $('body').addClass('is-app-nav-active')
      else if phase == 'cancel'
        eventX = event.x or event.changedTouches[0]?.pageX
        if eventX > MOBILE_NAV_WIDTH
          $('body').removeClass('is-app-nav-active')
          $('body').removeClass('is-site-nav-active')
      if phase != 'move'
        $appNav.attr('style', '')
        $siteNav.attr('style', '')
        $bodyDimmer.attr('style', '')
        $(this).attr('style', '')

  siteNavSwipe = (event, phase, direction, distance, duration, fingers, fingerData) ->
    if onMobile()
      distance = 0 if direction == 'up' or direction == 'down'
      if phase == 'move'
        px = distance
        px = px * -1 if direction == 'left'
        px = px + MOBILE_NAV_WIDTH if $('body').hasClass('is-site-nav-active')
        px = MOBILE_NAV_WIDTH * 1.2 if px > MOBILE_NAV_WIDTH * 1.2
        $(this).css
          "width": "100%"
          "left": "0"
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
          "-moz-transform": "translateX(#{px}px)"
          "-ms-transform": "translateX(#{px}px)"
          "-o-transform": "translateX(#{px}px)"
          "transform": "translateX(#{px}px)"
      else if phase == 'end'
        if distance > 20 or duration < 100
          if direction == 'left'
            $('body').removeClass('is-site-nav-active')
          if direction == 'right'
            $('body').addClass('is-site-nav-active')
      else if phase == 'cancel'
        eventX = event.x or event.changedTouches[0]?.pageX
        if eventX > MOBILE_NAV_WIDTH
          $('body').removeClass('is-app-nav-active')
          $('body').removeClass('is-site-nav-active')
      if phase != 'move'
        $siteNav.attr('style', '')
        $bodyDimmer.attr('style', '')
        $(this).attr('style', '')

    else if onTabletUp() and not $('html').hasClass('no-touch')
      distance = 0 if direction == 'up' or direction == 'down'
      if phase == 'move'
        px = distance
        px = px * -1 if direction == 'left'
        px = px - appNavWidth
        px = px + appNavWidth if $('body').hasClass('is-site-nav-active')
        px = 0 if px > 0
        rate = 1 + (px/appNavWidth)
        siteNavScaleDiff = siteNavHeight - appNavHeight
        scale = (appNavHeight + siteNavScaleDiff*rate) / siteNavHeight
        $(this).css
          "width": "100%"
          "left": "0"
        $siteNav.css
          "width": "#{appNavWidth}px"
          "-webkit-transition-property": "none"
          "-moz-transition-property": "none"
          "-o-transition-property": "none"
          "transition-property": "none"
          "-webkit-transition-duration": "0"
          "-moz-transition-duration": "0"
          "-o-transition-duration": "0"
          "transition-duration": "0"
          "-webkit-transform": "translateX(#{px}px) scaleY(#{scale})"
          "-webkit-transform": "translateX(#{px}px) scaleY(#{scale})"
          "-moz-transform": "translateX(#{px}px) scaleY(#{scale})"
          "-ms-transform": "translateX(#{px}px) scaleY(#{scale})"
          "-o-transform": "translateX(#{px}px) scaleY(#{scale})"
          "transform": "translateX(#{px}px) scaleY(#{scale})"
          "opacity": "#{rate * 0.5 + 0.5}"
        $siteNav.children('ul').children('li').css
          "-webkit-transition-property": "none"
          "-moz-transition-property": "none"
          "-o-transition-property": "none"
          "transition-property": "none"
          "-webkit-transition-duration": "0"
          "-moz-transition-duration": "0"
          "-o-transition-duration": "0"
          "transition-duration": "0"
          "opacity": "#{rate * 0.5}"

      else if phase == 'end'
        if distance > 20 or duration < 100
          if direction == 'left'
            $('body').removeClass('is-site-nav-active')
          if direction == 'right'
            $('body').addClass('is-site-nav-active')
      else if phase == 'cancel'
        $('body').addClass('is-site-nav-active')
      if phase != 'move'
        $siteNav.css
          "-webkit-transition-property": ""
          "-moz-transition-property": ""
          "-o-transition-property": ""
          "transition-property": ""
          "-webkit-transition-duration": ""
          "-moz-transition-duration": ""
          "-o-transition-duration": ""
          "transition-duration": ""
          "-webkit-transition": ""
          "-moz-transition": ""
          "-o-transition": ""
          "transition": ""
          "-webkit-transform": ""
          "-moz-transform": ""
          "-ms-transform": ""
          "-o-transform": ""
          "transform": ""
          "opacity": ""
        $siteNav.children('ul').children('li').css
          "-webkit-transition-property": ""
          "-moz-transition-property": ""
          "-o-transition-property": ""
          "transition-property": ""
          "-webkit-transition-duration": ""
          "-moz-transition-duration": ""
          "-o-transition-duration": ""
          "transition-duration": ""
          "-webkit-transition": ""
          "-moz-transition": ""
          "-o-transition": ""
          "transition": ""
          "opacity": ""
        $(this).attr('style', '')

  $appNavTouchTrigger.swipe
    swipeStatus: appNavSwipe
    allowPageScroll: "vertical"
    threshold: 5

  $appNav.swipe
    swipeStatus: appNavSwipe
    allowPageScroll: "vertical"
    threshold: 5

  $siteNavTouchTrigger.swipe
    swipeStatus: siteNavSwipe
    allowPageScroll: "vertical"
    threshold: 5

  $siteNav.swipe
    swipeStatus: siteNavSwipe
    allowPageScroll: "vertical"
    threshold: 5


  # ----- Mobile Nav ----- #

  setMobileNav = ->
    if onMobile()
      $('#body-dimmer').click ->
        $('body').removeClass('is-app-nav-active')
        $('body').removeClass('is-site-nav-active')

  setMobileNav()


  # ----- Tablet Nav ----- #

  setTabletNav = ->
    if onTabletUp()
      removeStyleFromPage('js-tablet-site-nav-css')
      css = []
      siteNavHeight = $siteNav.height()
      appNavHeight = $appNav.height()
      appNavWidth = $appNav.width()
      siteNavScale = appNavHeight / siteNavHeight
      # site-nav normal state
      css.push ".l-app > .app > .site-nav { width: #{appNavWidth}px !important; }"
      css.push ".l-app > .app > .site-nav { -webkit-transform: translateX(-#{appNavWidth}px) scaleY(0); -moz-transform: translateX(-#{appNavWidth}px) scaleY(0); -ms-transform: translateX(-#{appNavWidth}px) scaleY(0); -o-transform: translateX(-#{appNavWidth}px) scaleY(0); transform: translateX(-#{appNavWidth}px) scaleY(0); }" if onTablet()
      css.push ".l-app > .app > .site-nav { -webkit-transform: translateX(-#{appNavWidth}px) scaleY(#{siteNavScale}); -moz-transform: translateX(-#{appNavWidth}px) scaleY(#{siteNavScale}); -ms-transform: translateX(-#{appNavWidth}px) scaleY(#{siteNavScale}); -o-transform: translateX(-#{appNavWidth}px) scaleY(#{siteNavScale}); transform: translateX(-#{appNavWidth}px) scaleY(#{siteNavScale}); }" if onDesktop()
      # site-nav on app-nav active state
      css.push ".no-touch .l-app > .app > .app-logo:hover ~ .site-nav, .no-touch #site-nav-touch-trigger:hover ~ .l-app > .app > .site-nav, .is-app-nav-active .l-app > .app > .site-nav, .no-touch .l-app > .app > .app-nav:hover ~ .site-nav { -webkit-transform: translateX(-#{appNavWidth}px) scaleY(#{siteNavScale}); -moz-transform: translateX(-#{appNavWidth}px) scaleY(#{siteNavScale}); -ms-transform: translateX(-#{appNavWidth}px) scaleY(#{siteNavScale}); -o-transform: translateX(-#{appNavWidth}px) scaleY(#{siteNavScale}); transform: translateX(-#{appNavWidth}px) scaleY(#{siteNavScale}); }"
      # site-nav active state
      css.push ".no-touch #site-nav-touch-trigger:hover ~ .l-app > .app > .site-nav, .is-site-nav-active .l-app > .app > .site-nav, .no-touch .l-app > .app > .site-nav:hover { -webkit-transform: translateX(0) scaleY(1); -moz-transform: translateX(0) scaleY(1); -ms-transform: translateX(0) scaleY(1); -o-transform: translateX(0) scaleY(1); transform: translateX(0) scaleY(1); }"
      addStyleToPage(css, 'js-tablet-site-nav-css')
    else
      removeStyleFromPage('js-tablet-site-nav-css')

  setTabletNav()


  # ----- Refresh Events ----- #

  winResizeRefresh = ->
    appNavWidth = $appNav.width()
    appNavHeight = $appNav.height()
    siteNavHeight = $siteNav.height()
    appNavOffset = $appNav.offset()
    setMobileNav()
    setTabletNav()

  $(window).resize ->
    $('body').removeClass('is-app-nav-active')
    $('body').removeClass('is-site-nav-active')
    waitForFinalEvent (->
      winResizeRefresh()
    ), 100, "pageWinResizeR1537"
