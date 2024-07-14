# frozen_string_literal: true

# == Schema Information
#
# Table name: vendors
#
#  id                 :bigint           not null, primary key
#  name               :string
#  description        :text
#  image              :string
#  website            :string
#  social_media_links :json
#  category           :string
#  cuisine_type       :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Vendor < ApplicationRecord
  include Sluggable

  sluggable_attributes :name

  CUISINE_TYPES = [
    'American', 'Italian', 'Mexican', 'Chinese', 'Japanese',
    'Thai', 'Indian', 'Greek', 'French', 'Mediterranean',
    'Middle Eastern', 'Vietnamese', 'Korean', 'Spanish', 'German',
    'Caribbean', 'Seafood', 'Steakhouse', 'Barbecue', 'Pizza',
    'Sushi', 'Southern/Soul Food', 'Tex-Mex', 'Fusion', 'Vegetarian/Vegan',
    'Fast Food', 'Deli', 'Diner',
    'Brazilian', 'Peruvian', 'Ethiopian', 'Moroccan', 'Turkish',
    'Polish', 'Russian', 'Cuban', 'Filipino', 'Hawaiian',
    'Cajun/Creole', 'British', 'Irish', 'Portuguese', 'Australian',
    'Scandinavian', 'Indonesian', 'Malaysian', 'Gastropub', 'Farm-to-Table'
  ]
end
