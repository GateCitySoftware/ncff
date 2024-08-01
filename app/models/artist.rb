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
#  tagline    :string
#  owner_id   :uuid
#  headliner  :boolean          default(FALSE), not null
#
class Artist < ApplicationRecord
  include PrimaryImage
  include Sluggable
  include Uploadable
  include Linkable

  sluggable_attributes :name

  has_many :performances
  has_many :tagged_items, as: :taggable, dependent: :destroy
  has_many :tags, through: :tagged_items
  has_many :embedded_contents, as: :embeddable

  scope :by_genre, lambda { |genre|
                     joins(:tags).where(tags: { category: 'music', sub_category: 'genre', name: genre })
                   }
  scope :by_stage, ->(stage) { joins(performances: :stage).where(stages: { name: stage }).distinct }
  scope :by_date, ->(date) { joins(:performances).where('performances.start_time::date = ?', date).distinct }

  def genres
    tags.genres.pluck(:name)
  end
end
