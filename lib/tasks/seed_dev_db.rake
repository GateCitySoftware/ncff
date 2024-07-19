# frozen_string_literal: true

task seed_dev_db: :environment do
  require 'vendor_generator'

  Vendor::CATEGORIES.keys.each do |category|
    50.times do
      params = VendorGenerator.new(category).call
      Vendor.create!(params)
    end
  end

  puts "Vendors created! Total vendor count: #{Vendor.count}"
end

task seed_tags: :environment do
  genres = [
    'Rock', 'Pop', 'Hip Hop', 'R&B', 'Country',
    'Jazz', 'Blues', 'Classical', 'Electronic', 'Dance',
    'Reggae', 'Folk', 'Alternative', 'Indie', 'Metal',
    'Punk', 'Soul', 'Funk', 'Disco', 'Techno',
    'House', 'Trance', 'Ambient', 'Rap', 'Gospel',
    'Latin', 'World', 'New Age', 'Ska', 'Grunge',
    'Experimental', 'Instrumental', 'Acoustic', 'Bluegrass', 'Opera',
    'Soundtrack', 'EDM', 'Trap', 'Dubstep', 'Grime',
    'K-Pop', 'J-Pop', 'Salsa', 'Bossa Nova', 'Flamenco',
    'Afrobeat', 'Reggaeton', 'Synthwave', 'Lofi', 'Psychedelic'
  ]
  genres.each do |genre|
    puts "creating genre: #{genre}"
    Tag.find_or_create_by!(name: genre, category: 'music', sub_category: 'genre')
  end
  cuisine_types = [
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
  cuisine_types.each do |cuisine_type|
    puts "creating cuisine_type: #{cuisine_type}"
    Tag.find_or_create_by!(name: cuisine_type, category: 'food-drink', sub_category: 'cuisine')
  end
end
