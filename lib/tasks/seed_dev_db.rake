# frozen_string_literal: true

task create_vendors: :environment do
  require 'vendor_generator'

  Vendor::CATEGORIES.keys.each do |category|
    50.times do
      params = VendorGenerator.new(category).call
      Vendor.create!(params)
    end
  end
  Vendor.all.each do |vendor|
    vendor.update(
      phone: Faker::PhoneNumber.phone_number,
      email: Faker::Internet.email,
      address: Faker::Address.full_address
    )
  end

  puts "Vendors created! Total vendor count: #{Vendor.count}"
end

task create_genre_and_cuisine_tags: :environment do
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

task attach_youtube_videos_to_artists: :environment do
  embed_codes = [
    '<iframe width="560" height="315" src="https://www.youtube.com/embed/rPVQlQQgPLg?si=fvuXt6dpahRUUpWc" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>',
    '<iframe width="560" height="315" src="https://www.youtube.com/embed/rPVQlQQgPLg?si=fvuXt6dpahRUUpWc" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>',
    '<iframe width="560" height="315" src="https://www.youtube.com/embed/YcHL0kUFPhw?si=rHtuP9G_TxvMvCFb" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>',
    '<iframe width="560" height="315" src="https://www.youtube.com/embed/tNV16tz1NK0?si=ve--BunDqfieYFqx" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>',
    '<iframe width="560" height="315" src="https://www.youtube.com/embed/tNV16tz1NK0?si=gwCTxdqvfbp_c53h" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>',
    '<iframe width="560" height="315" src="https://www.youtube.com/embed/QmlLdntYnpU?si=zIM6WXteCW077CG9" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>',
    '<iframe width="560" height="315" src="https://www.youtube.com/embed/nGLjDIDxjGM?si=1H-bvoLoWszh1Ftc" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>',
    '<iframe width="560" height="315" src="https://www.youtube.com/embed/_lsran_Slzc?si=BkhbjxsnG9jrpwTp" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>'
  ]

  Artist.all.each do |artist|
    artist.embedded_contents.create!(
      embed_code: embed_codes.sample,
      url: 'https://www.youtube.com/watch?v=1234567890',
      content_type: 'YouTube Video',
      title: 'Placeholder YouTube Video - UPDATE ME',
      description: 'This is a placeholder YouTube video. Please update this with a real video.'
    )
  end
end

task add_cuisine_tags_to_eat_drink_vendors: :environment do
  Vendor.by_category('eat_drink').each do |vendor|
    tag_count = rand(1..3)
    Tag.cuisines.sample(tag_count).each do |tag|
      TaggedItem.find_or_create_by!(tag_id: tag.id, taggable_type: 'Vendor', taggable_id: vendor.id)
    end
  end
end

task add_photos_to_vendor: :environment do
  s3_uploader = S3Uploader.new('gcs-ncff')

  Dir.glob(Rails.root.join('app', 'assets', 'images', '*')).each do |file_path|
    next unless file_path.include?('images/res-')

    file_name = File.basename(file_path)
    file_size = File.size(file_path)
    content_type = Marcel::MimeType.for(Pathname.new(file_path))

    # Generate a unique key for S3
    key = "#{SecureRandom.uuid}-#{file_name}"

    # Upload file to S3
    if s3_uploader.upload(file_path, key)
      # Create Upload record
      upload = Upload.new(
        filename: file_name,
        content_type:,
        file_size:,
        key:
      )
      upload.uploadable = Vendor.first
      upload.image_type = 'gallery'
      upload.save!

      puts "Uploaded #{file_name} to S3 and created Upload record"
    else
      puts "Failed to upload #{file_name} to S3"
    end
  end
end

task seed_everything: :environment do
  tasks = %w[
    create_vendors
    create_genre_and_cuisine_tags
    add_cuisine_tags_to_eat_drink_vendors
    seed_real_data
    tag_artists_with_genres
    attach_youtube_videos_to_artists
    add_photos_to_vendors
  ]
  tasks.each do |task|
    puts "Starting task: #{task}"
    Rake::Task[task].invoke
    puts "Finished task: #{task}"
  end
end
