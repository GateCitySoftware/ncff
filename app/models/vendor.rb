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
    activation: 'Activations'
  }.freeze

  scope :by_category, ->(category) { where(category:) }
  scope :by_tag, ->(tag) { joins(:tags).where(tags: { name: tag }) }

  sluggable_attributes :name

  def cuisine_map
    Tag.where(category: 'food-drink', sub_category: 'cuisine')
  end

  def social_media_links
    external_links.social_media_links
  end
end
