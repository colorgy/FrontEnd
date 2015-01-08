# 針對不同瀏覽器及系統的處理
if window.chrome
  isChrome = true
  $('html').addClass 'chrome'
if Modernizr.touch
  isTouch = true
  $('html').addClass 'touch'
else
  $('html').addClass 'non-touch'
if navigator.platform.toUpperCase().indexOf('MAC')>=0
  isMac = true
  $('html').addClass 'mac'
if navigator.platform.match(/(iPhone|iPod|iPad)/i)
  isIOS = true
  $('html').addClass 'ios'
if navigator.appVersion.match(/(Win)/i)
  isWin = true
  $('html').addClass 'windows'
