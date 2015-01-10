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

  # ----- Register Events ----- #

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
    else if onTablet() and not $('body').hasClass('no-touch')
      $('body').toggleClass('is-app-nav-active')
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

  # ----- Mobile Nav ----- #
  setMobileNav = ->
    if onMobile()

      mobileNavSwipe = (event, phase, direction, distance, duration, fingers, fingerData) ->
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
        distance = 0 if direction == 'up' or direction == 'down'
        if phase == 'move'
          px = distance
          distance = 0 if direction == 'up' or direction == 'down'
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

      $("#app-nav-touch-trigger").swipe
        swipeStatus: mobileNavSwipe
        allowPageScroll: "vertical"
        threshold: 5

      $appNav.swipe
        swipeStatus: mobileNavSwipe
        allowPageScroll: "vertical"
        threshold: 5

      $("#site-nav-touch-trigger").swipe
        swipeStatus: siteNavSwipe
        allowPageScroll: "vertical"
        threshold: 5

      $siteNav.swipe
        swipeStatus: siteNavSwipe
        allowPageScroll: "vertical"
        threshold: 5

      $('#body-dimmer').click ->
        $('body').removeClass('is-app-nav-active')
        $('body').removeClass('is-site-nav-active')
    else
      $appNav.off()
      $siteNav.off()

  setMobileNav()

  setTabletNav = ->
    if onTablet()
      removeStyleFromPage('js-tablet-site-nav-css')
      css = []
      siteNavHeight = $siteNav.height()
      appNavHeight = $appNav.height()
      appNavWidth = $appNav.width()
      siteNavScale = appNavHeight / siteNavHeight
      css.push ".l-app > .app > .site-nav { margin-left: -#{appNavWidth}px; }"
      css.push ".site-nav { -webkit-transform: translateX(0) scaleY(0); -moz-transform: translateX(0) scaleY(0); -ms-transform: translateX(0) scaleY(0); -o-transform: translateX(0) scaleY(0); }"
      css.push ".no-touch .app-logo:hover ~ .site-nav, .app-nav:hover ~ .site-nav, #site-nav-touch-trigger:hover ~ * .site-nav, .is-app-nav-active .site-nav { -webkit-transform: translateX(0) scaleY(#{siteNavScale}); -moz-transform: translateX(0) scaleY(#{siteNavScale}); -ms-transform: translateX(0) scaleY(#{siteNavScale}); -o-transform: translateX(0) scaleY(#{siteNavScale}); }"
      css.push ".no-touch #site-nav-touch-trigger:hover ~ * .site-nav, .no-touch .site-nav:hover, .is-site-nav-active .site-nav { -webkit-transform: translateX(#{appNavWidth}px) scaleY(1); -moz-transform: translateX(#{appNavWidth}px) scaleY(1); -ms-transform: translateX(#{appNavWidth}px) scaleY(1); -o-transform: translateX(#{appNavWidth}px) scaleY(1); }"
      # css.push ".no-touch .is-site-nav-active .app-logo:hover ~ .site-nav, .is-site-nav-active .app-nav:hover ~ .site-nav, .is-app-nav-active.is-site-nav-active .site-nav { -webkit-transform: translateX(0) scaleY(#{siteNavScale}); -moz-transform: translateX(0) scaleY(1); -ms-transform: translateX(0) scaleY(1); -o-transform: translateX(0) scaleY(1); }"
      addStyleToPage(css, 'js-tablet-site-nav-css')
    else
      removeStyleFromPage('js-tablet-site-nav-css')

  setTabletNav()

  winResizeRefresh = ->
    setMobileNav()
    setTabletNav()
    $('body').removeClass('is-app-nav-active')
    $('body').removeClass('is-site-nav-active')

  $(window).resize ->
    waitForFinalEvent (->
      winResizeRefresh()
    ), 100, "pageWinResizeR1537"
