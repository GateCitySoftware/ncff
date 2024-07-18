# frozen_string_literal: true

# == Schema Information
#
# Table name: vendors
#
#  id           :bigint           not null, primary key
#  name         :string
#  description  :text
#  image        :string
#  website      :string
#  category     :string
#  cuisine_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  slug         :string
#
class Vendor < ApplicationRecord
  include CardImage
  include Sluggable
  include Uploadable
  include Linkable
  # 1. DELETE CUISINE TYPE

  CATEGORIES  = ['Eat & Drink'

  sluggable_attributes :name

  scope :by_tag, ->(genre) { joins(:tags).where(tags: { name: genre, category: 'vendor' }) }

  def social_media_links
    external_links.social_media_links
  end
end
