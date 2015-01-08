$app = $('.app')
if $app.length
  if $app.children('.app-menu')?.children()?.children()?.length
    $app.addClass 'has-app-menu'


