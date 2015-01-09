## *************************************
##
##   JS Complement for Page Layouts
##
## *************************************

# Constants
MEDIUM_SCREEN_SIZE = 700
LARGE_SCREEN_SIZE = 1200

# -------------------------------------
#   Application Layout
# -------------------------------------

$app = $('.app')
if $app.length
  # check if the page has a App Menu
  if $app.children('.app-menu')?.children()?.children()?.length
    $app.addClass 'has-app-menu'

  # move
  # moveAppNavDom = ->
  #   if $(window).width() > MEDIUM_SCREEN_SIZE
  #     $("body > #app-nav")?.detach().insertBefore(".main")
  #   else
  #     $(".app > #app-nav")?.detach().insertBefore("#wrapper")
  # moveAppNavDom()

  # $(window).resize ->
  #   moveAppNavDom()
