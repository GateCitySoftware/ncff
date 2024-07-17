# frozen_string_literal: true

# == Schema Information
#
# Table name: schedules
#
#  id         :uuid             not null, primary key
#  name       :string
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#
class Schedule < ApplicationRecord
  include Sluggable

  sluggable_attributes :name

  # Not sure if we actually need a schedule?
  # really just a stage/day
end
