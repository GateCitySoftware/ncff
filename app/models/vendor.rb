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

  sluggable_attributes :name
end
