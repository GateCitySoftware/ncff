# frozen_string_literal: true

# == Schema Information
#
# Table name: vendors
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  image       :string
#  website     :string
#  category    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#
class Vendor < ApplicationRecord
  include CardImage
  include Sluggable
  include Uploadable
  include Linkable

  has_many :tagged_items, as: :taggable
  has_many :tags, through: :tagged_items

  CATEGORIES = {
    eat_drink: 'Eat & Drink',
    shop_do: 'Shop & Do',
    activation: 'Activation'
  }.freeze

  sluggable_attributes :name

  scope :by_vendor_tag, ->(tag) { joins(tagged_items: :tags).where(tags: { name: tag, category: 'vendor' }) }

  def social_media_links
    external_links.social_media_links
  end
end
