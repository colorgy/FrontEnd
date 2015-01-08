//= require ./vendor/positionsticky
//= require ./vendor/stickyfill
//= require_directory ./polyfills

(function () {
  if (!Modernizr.csspositionsticky) {
    $('.js-sticky').Stickyfill();
    // $('.app-nav.js-sticky ~ div').remove();
  }

  fullWidthBackground();

  $(window).resize(function() {
    fullWidthBackground();
    // $('.js-sticky').Stickyfill();
    // $('.app-nav.js-sticky ~ div').remove();
  });
})();
