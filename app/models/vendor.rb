# frozen_string_literal: true

class Vendor < ApplicationRecord
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
