(function($) {
  $.fn.removeStyle = function(style) {
    var search = new RegExp(style + '[^;]+;?', 'g');

    return this.each(function() {
      $(this).attr('style', function(i, style) {
        return style.replace(search, '');
      });
    });
  };
}(jQuery));
