FactoryBot.define do
  factory :activation do
    name { Faker::Company.name }
    description { Faker::Lorem.paragraph }
    image { Faker::Internet.url }
    website { Faker::Internet.url }
    social_media_links { { facebook: Faker::Internet.url, twitter: Faker::Internet.url } }
    slug { Faker::Internet.slug }
  end

  factory :artist do
    name { Faker::Name.name }
    bio { Faker::Lorem.paragraph }
    slug { Faker::Internet.slug }
  end

  factory :performance do
    association :stage
    association :artist
    start_time { Faker::Time.forward(days: 30) }
    end_time { |p| p.start_time + 2.hours }
    description { Faker::Lorem.paragraph }
    is_headline { Faker::Boolean.boolean }
  end

  factory :schedule do
    name { Faker::Lorem.word }
    date { Faker::Date.forward(days: 30) }
    slug { Faker::Internet.slug }
  end

  factory :stage do
    name { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    google_place_id { Faker::Alphanumeric.alphanumeric(number: 10) }
    google_place_address { Faker::Address.full_address }
    slug { Faker::Internet.slug }
  end

  factory :tagged_item do
    association :tag
    association :taggable, factory: :artist # You can change this to any taggable model
  end

  factory :tag do
    name { Faker::Lorem.word }
    category { Faker::Lorem.word }
  end

  factory :upload do
    filename { Faker::File.file_name }
    content_type { Faker::File.mime_type }
    file_size { Faker::Number.number(digits: 6) }
    key { Faker::Alphanumeric.alphanumeric(number: 20) }
    image_type { 'gallery' }
    association :uploadable, factory: :artist # You can change this to any uploadable model
  end

  factory :user do
    email { Faker::Internet.email }
    login_token { Faker::Alphanumeric.alphanumeric(number: 20) }
    login_token_valid_until { Faker::Time.forward(days: 1) }
  end

  factory :vendor do
    name { Faker::Company.name }
    description { Faker::Lorem.paragraph }
    image { Faker::Internet.url }
    website { Faker::Internet.url }
    social_media_links { { facebook: Faker::Internet.url, twitter: Faker::Internet.url } }
    category { Faker::Lorem.word }
    cuisine_type { Faker::Restaurant.type }
    slug { Faker::Internet.slug }
  end
end
