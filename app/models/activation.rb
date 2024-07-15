# == Schema Information
#
# Table name: activations
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  image       :string
#  website     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#
class Activation < ApplicationRecord
  include CardImage
  include Sluggable
  include Uploadable
  include Linkable

  sluggable_attributes :name
end
