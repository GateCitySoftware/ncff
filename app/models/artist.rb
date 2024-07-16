# frozen_string_literal: true

# == Schema Information
#
# Table name: artists
#
#  id         :uuid             not null, primary key
#  name       :string
#  bio        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#
class Artist < ApplicationRecord
  include CardImage
  include Sluggable
  include Uploadable
  include Linkable

  sluggable_attributes :name

  has_many :performances
  has_many :tagged_items, as: :taggable, dependent: :destroy
  has_many :tags, through: :tagged_items
end
