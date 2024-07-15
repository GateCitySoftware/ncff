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
  include CardImage
  include Sluggable
  include Uploadable

  sluggable_attributes :name
end
