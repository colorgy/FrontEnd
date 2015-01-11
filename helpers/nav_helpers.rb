module NavHelpers
  def nav_link(link_text, link_path)

    if link_path[/^https?:\/\//] then
      content_tag(:li, :class => 'cross-domin') do
        '<a href="' + link_path + '" target="_blank" class="cross-domin">' + link_text + '</a>'
      end

    else
      is_active = (current_page.path == link_path) ? 'active' : ''
      if (link_path == '/' && current_page.url == '/') || \
         (current_page.url.slice(/\/?[^\/]*\//).chomp('/') == link_path.chomp('/'))
        is_active = 'active'
      end

      content_tag(:li, :class => is_active) do
        link_to link_text, link_path
      end
    end
  end
end
