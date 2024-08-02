# == Schema Information
#
# Table name: external_links
#
#  id            :uuid             not null, primary key
#  url           :string
#  link_type     :string
#  linkable_type :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  linkable_id   :uuid
#
class ExternalLink < ApplicationRecord
  LINK_TYPES = {
    'facebook' => { bi_icon: 'bi-facebook', display_text: 'Facebook', color_hex_code: '#6C8BC1' },
    'instagram' => { bi_icon: 'bi-instagram', display_text: 'Instagram', color_hex_code: '#C17A8B' },
    'linkedin' => { bi_icon: 'bi-linkedin', display_text: 'LinkedIn', color_hex_code: '#6E95B5' },
    'pinterest' => { bi_icon: 'bi-pinterest', display_text: 'Pinterest', color_hex_code: '#A66B75' },
    'tiktok' => { bi_icon: 'bi-tiktok', display_text: 'TikTok', color_hex_code: '#4D4D4D' },
    'twitter' => { bi_icon: 'bi-twitter', display_text: 'Twitter', color_hex_code: '#7FBCE6' },
    'website' => { bi_icon: 'bi-globe', display_text: 'Website', color_hex_code: '#8CADD9' },
    'youtube' => { bi_icon: 'bi-youtube', display_text: 'YouTube', color_hex_code: '#C16666' }
  }.freeze

  SOCIAL_MEDIA = %w[facebook instagram linkedin pinterest tiktok twitter youtube].freeze

  LINK_ORDER = %w[website instagram facebook youtube tiktok twitter linkedin pinterest].freeze

  has_paper_trail
  belongs_to :linkable, polymorphic: true

  validates :url, presence: true
  validates :linkable_type, presence: true
  validates :linkable_id, presence: true
  validates :link_type, presence: true, inclusion: { in: LINK_TYPES.keys }

  scope :social_media_links, -> { where(link_type: SOCIAL_MEDIA) }

  scope :ordered_by_link_type, lambda {
    order(Arel.sql("CASE link_type
      #{LINK_ORDER.map.with_index { |link, index| "WHEN '#{link}' THEN #{index}" }.join(' ')}
      ELSE #{LINK_ORDER.length}
    END"))
  }

  def bootstrap_icon_value
    LINK_TYPES[link_type][:bi_icon]
  end
end
