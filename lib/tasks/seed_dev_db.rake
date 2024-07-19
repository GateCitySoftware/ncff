# frozen_string_literal: true

task seed_dev_db: :environment do
  require 'faker'

  # Seed Vendors
  50.times do
    Vendor.create!(
      name: Faker::Restaurant.name,
      description: Faker::Restaurant.description,
      image: Faker::LoremFlickr.image(size: '300x300', search_terms: ['food']),
      website: Faker::Internet.url,
      social_media_links: {
        instagram: "@#{Faker::Internet.username}",
        facebook: Faker::Internet.username
      },
      category: %w[food_truck bar downtown_business late_night].sample
    )
  end

  # Seed Merchants
  50.times do
    Merchant.create!(
      name: Faker::Company.name,
      description: Faker::Company.catch_phrase,
      image: Faker::LoremFlickr.image(size: '300x300', search_terms: ['craft']),
      website: Faker::Internet.url,
      social_media_links: {
        instagram: "@#{Faker::Internet.username}",
        etsy: Faker::Internet.username
      },
      product_type: %w[Jewelry Crafts Soaps Woodworking Clothes Fiber Art].sample
    )
  end

  # Seed Activations
  50.times do
    Activation.create!(
      name: Faker::Company.name + ' Experience',
      description: Faker::Marketing.buzzwords,
      image: Faker::LoremFlickr.image(size: '300x300', search_terms: ['event']),
      website: Faker::Internet.url,
      social_media_links: {
        instagram: "@#{Faker::Internet.username}",
        twitter: "@#{Faker::Internet.username}"
      }
    )
  end

  puts 'Database seeded successfully!'
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
    Tag.find_or_create_by!(name: genre, category: 'genre')
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
    Tag.find_or_create_by!(name: cuisine_type, category: 'vendor')
  end
end
