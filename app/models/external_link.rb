# == Schema Information
#
# Table name: external_links
#
#  id            :bigint           not null, primary key
#  url           :string
#  link_type     :string
#  linkable_type :string           not null
#  linkable_id   :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class ExternalLink < ApplicationRecord
  LINK_TYPES = {
    'facebook' => { bi_icon: 'bi-facebook', display_text: 'Facebook' },
    'instagram' => { bi_icon: 'bi-instagram', display_text: 'Instagram' },
    'linkedin' => { bi_icon: 'bi-linkedin', display_text: 'LinkedIn' },
    'pinterest' => { bi_icon: 'bi-pinterest', display_text: 'Pinterest' },
    'tiktok' => { bi_icon: 'bi-tiktok', display_text: 'TikTok' },
    'twitter' => { bi_icon: 'bi-twitter', display_text: 'Twitter' },
    'website' => { bi_icon: 'bi-globe', display_text: 'Website' },
    'youtube' => { bi_icon: 'bi-youtube', display_text: 'YouTube' }
  }.freeze

  belongs_to :linkable, polymorphic: true

  validates :url, presence: true
  validates :linkable_type, presence: true
  validates :linkable_id, presence: true
  validates :link_type, presence: true, inclusion: { in: LINK_TYPES.keys }

  def bootstrap_icon_value
    LINK_TYPES[link_type][:bi_icon]
  end
end
