require 'json'
require 'open-uri'
require 'fileutils'

namespace :artist_images do
  desc 'Download artist card images to tmp/artist_card_images'
  task :download do
    # Ensure the target directory exists
    target_dir = Rails.root.join('tmp', 'artist_card_images')
    FileUtils.mkdir_p(target_dir)

    # Read and parse the JSON data
    json_data = File.read('lib/assets/artists_and_images.json')
    artists = JSON.parse(json_data)

    # Download each image
    artists.each do |artist|
      name = artist['artist'].downcase.gsub(/[^a-z0-9]+/, '_')
      url = artist['image']
      extension = File.extname(url)
      filename = "#{name}#{extension}"
      filepath = target_dir.join(filename)

      puts "Downloading #{filename}..."

      begin
        File.open(filepath, 'wb') do |file|
          file.write URI.open(url).read
        end
        puts "Successfully downloaded #{filename}"
      rescue StandardError => e
        puts "Error downloading #{filename}: #{e.message}"
      end
    end

    puts 'Download complete!'
  end
end
