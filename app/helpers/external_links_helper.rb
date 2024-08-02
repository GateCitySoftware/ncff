module ExternalLinksHelper
  def external_link_button(link)
    link_type = link.link_type.downcase
    link_info = ExternalLink::LINK_TYPES[link_type]

    if link_info
      content_tag :a,
                  href: link.url,
                  target: '_blank',
                  rel: 'noopener noreferrer',
                  class: 'btn border',
                  style: "background-color: #{link_info[:color_hex_code]}; color: white;" do
        content_tag(:i, '', class: "bi #{link_info[:bi_icon]} me-1") +
          link_info[:display_text]
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
