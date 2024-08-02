module ExternalLinks
  extend ActiveSupport::Concern

  included do
    has_many :external_links, as: :linkable, dependent: :destroy
  end

  # Add common methods related to external links
  def add_external_link(url, link_type = nil)
    external_links.create(url:, link_type:)
  end

  def remove_external_link(link_id)
    external_links.find(link_id).destroy
  end
end
