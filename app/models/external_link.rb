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
  LINK_TYPES = %w[Facebook Instagram LinkedIn Pinterest TikTok Twitter Website YouTube].freeze

  belongs_to :linkable, polymorphic: true

  validates :url, presence: true
  validates :linkable_type, presence: true
  validates :linkable_id, presence: true
end
