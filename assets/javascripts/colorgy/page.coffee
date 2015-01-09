## *************************************
##
##   JS Complement for Page Layouts
##
## *************************************

# Constants
MEDIUM_SCREEN_SIZE = 700
LARGE_SCREEN_SIZE = 1200
MOBILE_NAV_WIDTH = 230
LOGO_WIDTH = 45
WINDOW_WIDTH = $(window).width()

$(window).resize ->
  WINDOW_WIDTH = $(window).width()

onMobile = ->
  WINDOW_WIDTH < MEDIUM_SCREEN_SIZE

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

      $("#app-nav-touch-trigger").swipe
        swipeStatus: mobileNavSwipe
        allowPageScroll: "vertical"
        threshold: 5

      $appNav.swipe
        swipeStatus: mobileNavSwipe
        allowPageScroll: "vertical"
        threshold: 5

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

  setMobileNav()

  $(window).resize ->
    setMobileNav()
    WINDOW_WIDTH = $(window).width()
