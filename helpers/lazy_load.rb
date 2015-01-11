# This requires jquery_lazyload and activate :automatic_image_sizes
#
# Usage:
# ll_img "path/to/image" [,"alt"] # for asset
# ll_img "path/to/image", "width+px", "height+px" [,"alt"] # for things outside
#

module LazyLoad
  def ll_img(src, a="", b="", c="")
    if src[/https?:\/\//]
      return '<noscript><img src="' + src + '" width="' + a + '" height="' + b + '" title="' + c + '"></noscript><img src="http://placehold.it/' + a.chomp('px') + 'x' + b.chomp('px') + '/bbbbbb/bbbbbb" width="' + a + '" height="' + b + '" title="' + c + '" data-original="' + src + '" class="lazy">'
    else
      img_t = image_tag src, :alt => a, :class => 'lazy'
      img_t_org = image_tag src, :alt => a
      img_t.sub! ' src="', ' data-original="'
      img_width = img_t.scan(/width="([0-9]+)/)[0]
      img_width = img_width && img_width[0]
      img_height = img_t.scan(/height="([0-9]+)/)[0]
      img_height = img_height && img_height[0]
      img_t = img_t.chomp('>').chomp('/').chomp(' ') + ' src="http://placehold.it/' + img_width + 'x' + img_height + '/bbbbbb/bbbbbb">'
      return '<noscript>' + img_t_org + '</noscript>' + img_t
    end
  end
end
