//= require jquery
//= require bootstrap
//= require_directory ./lib

//= require ./vendor/jquery.touchSwipe

//= require ./page
//= require ./polyfill

$(document).on('ready page:load', function() {
  setTimeout(function() {
    $('.dropdown-toggle').dropdown();
  }, 500);
});
