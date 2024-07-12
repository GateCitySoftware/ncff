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
      category: %w[food_truck bar downtown_business late_night].sample,
      cuisine_type: Faker::Restaurant.type
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
