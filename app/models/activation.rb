# == Schema Information
#
# Table name: activations
#
#  id                 :bigint           not null, primary key
#  name               :string
#  description        :text
#  image              :string
#  website            :string
#  social_media_links :json
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Activation < ApplicationRecord
  include Sluggable
  include CardImage

  sluggable_attributes :name
end
