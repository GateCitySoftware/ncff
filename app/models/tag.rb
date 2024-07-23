# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string
#  category   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :category }
  validates :category, presence: true

  has_many :tagged_items
  has_many :artists, through: :tagged_items, source: :taggable, source_type: 'Artist'
  has_many :vendors, through: :tagged_items, source: :taggable, source_type: 'Vendor'

  scope :genres, -> { where(category: 'music', sub_category: 'genre') }
  scope :cuisines, -> { where(category: 'food-drink', sub_category: 'cuisine') }

  attr_accessor :tagged_items_count

  def self.with_count(reload: false)
    #  tap do
    #    if cache_hit = Rails.cache.fetch('tags_with_count')
    #    if not_cached? || reload
    #      all.each { |tag| tag.map { tagged_items.count } }
    #    else
    #      # retrieve cached count if it exists
    #      Rails.cache.fetch('tags_with_count', expires_in: 30.minutes) do
    #      end
    #    end
    #  end
  end

  def self.genre_map
    Rails.cache.fetch('cuisine_map', expires_in: 30.minutes) do
      hash = genres.map { |genre| [genre.name, genre.artists.count] }.sort.to_h
      hash.reject { |_k, v| v.zero? }.to_h
    end
  end

  def self.cuisine_map
    Rails.cache.fetch('cuisine_map', expires_in: 30.minutes) do
      hash = cuisines.map { |cuisine| [cuisine.name, cuisine.vendors.count] }.sort.to_h
      hash.reject { |_k, v| v.zero? }.to_h
    end
  end
end
