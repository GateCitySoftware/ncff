# == Schema Information
#
# Table name: vendors
#
#  id          :uuid             not null, primary key
#  name        :string
#  description :text
#  image       :string
#  website     :string
#  category    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#  phone       :string
#  email       :string
#  address     :text
#  owner_id    :uuid
#  approved    :boolean          default(FALSE), not null
#  archived    :boolean          default(FALSE), not null
#  city        :string
#  state       :string
#
class Vendor < ApplicationRecord
  include Slugs
  include Images
  include ExternalLinks

  CATEGORIES = {
    eat_drink: 'Eat & Drink',
    shop_do: 'Shop & Do',
    activation: 'Activations'
  }.freeze

  has_paper_trail

  validates :category, inclusion: { in: CATEGORIES.keys.map(&:to_s) }

  has_many :tagged_items, as: :taggable
  has_many :tags, through: :tagged_items

  scope :by_category, ->(category) { where(category:) }
  scope :by_tag, ->(tag) { joins(:tags).where(tags: { name: tag }) }

  sluggable_attributes :name

  default_scope { where(approved: true, archived: false) }

  # "normal" website is attached via ExternalLink, this is for a menu link only
  def menu_link
    website
  end

  def category_name
    CATEGORIES[category.to_sym]
  end

  def cuisine_map
    Tag.where(category: 'food-drink', sub_category: 'cuisine')
  end

  def social_media_links
    external_links.social_media_links
  end
end
