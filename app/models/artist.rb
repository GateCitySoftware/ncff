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
#  hide_tile  :boolean          default(FALSE)
#
class Artist < ApplicationRecord
  include Slugs
  include Images
  include ExternalLinks

  has_paper_trail
  has_rich_text :content

  sluggable_attributes :name

  has_many :performances, dependent: :destroy
  has_many :tagged_items, as: :taggable, dependent: :destroy
  has_many :tags, through: :tagged_items
  has_many :embedded_contents, as: :embeddable, dependent: :destroy

  scope :by_genre, lambda { |genre|
                     joins(:tags).where(tags: { category: 'music', sub_category: 'genre', name: genre })
                   }
  scope :by_stage, ->(stage) { joins(performances: :stage).where(stages: { name: stage }).distinct }
  scope :by_date, ->(date) { joins(:performances).where('performances.start_time::date = ?', date).distinct }

  def no_show_tile?
    _name = name.downcase
    _name.include?('prize') ||
      _name.include?('workshop') ||
      _name.include?('open mic') ||
      _name.include?('drum circle') ||
      _name == 'old time' ||
      _name == 'jazz' ||
      _name.include?('drum circle') ||
      _name.include?('contest') ||
      (_name.include?('jam') && !_name.include?('hot pepper'))
  end

  def genres
    tags.genres.pluck(:name)
  end

  def stringified_performances
    performances.includes(:stage).map do |performance|
      "#{performance.start_time.strftime('%A at %I:%M %p')} on #{performance.stage.name}"
    end
  end

  def performance_summary
    "#{name} performs on #{stringified_performances.to_sentence}."
  end
end
