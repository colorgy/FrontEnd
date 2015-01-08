//= require ./vendor/positionsticky
//= require ./vendor/stickyfill
//= require ./css_polyfills/full_width_bg

(function () {
  if (!Modernizr.csspositionsticky) {
    $('.js-sticky').Stickyfill();
    // $('.app-nav.js-sticky ~ div').remove();
  }

  fullWidthBackground();

  $(window).resize(function() {
    fullWidthBackground();
    $('.js-sticky').Stickyfill();
    // $('.app-nav.js-sticky ~ div').remove();
  });
})();
