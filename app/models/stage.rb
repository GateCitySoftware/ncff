# frozen_string_literal: true

# == Schema Information
#
# Table name: stages
#
#  id                   :uuid             not null, primary key
#  name                 :string
#  description          :text
#  google_place_id      :string
#  google_place_address :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  slug                 :string
#
class Stage < ApplicationRecord
  include Slugs
  include Images
  has_paper_trail

  validates :name, presence: true, uniqueness: true

  STAGE_ORDER = [
    'City Stage NC @ The Depot',
    'Summit Stage',
    'LeBauer Park',
    'Elm St. Stage',
    'Center City Jams',
    'Dance at Van Dyke'
  ]

  sluggable_attributes :name

  def self.ordered
    all.sort_by { |record| STAGE_ORDER.index(record.name) }
  end
end
