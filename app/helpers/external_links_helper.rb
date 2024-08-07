module ExternalLinksHelper
  def external_link_button(link, icon_only: false)
    link_type = link.link_type.downcase
    link_info = ExternalLink::LINK_TYPES[link_type]

    if link_info
      anchor_args = {
        href: link.url,
        target: '_blank',
        rel: 'noopener noreferrer',
        class: 'btn border w-100',
        style: "background-color: #{link_info[:color_hex_code]}; color: white;"
      }

      anchor_args[:class] = 'btn btn-sm' if icon_only

      content_tag :a, anchor_args do
        if icon_only
          content_tag(:i, '', class: "bi #{link_info[:bi_icon]} m-1")
        else
          content_tag(:i, '', class: "bi #{link_info[:bi_icon]} me-1") + link_info[:display_text]
        end
      end
    else
      # Default button for unknown link types
      content_tag :a,
                  'Visit Link',
                  href: link.url,
                  target: '_blank',
                  rel: 'noopener noreferrer',
                  class: 'btn btn-sm btn-secondary'
    end
  end
end
