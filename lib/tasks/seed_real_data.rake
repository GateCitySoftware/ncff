task seed_real_data: :environment do
  JSON.parse(File.read('lib/assets/draft_schedule.json'))['schedule'].each do |performance|
    stage = Stage.find_or_create_by!(name: performance['stage_name'])
    artist = Artist.find_or_create_by!(name: performance['act'])

    start_time = performance['time']
    end_time = performance['end_time']
    date = performance['date']

    start_time = DateTime.parse("#{date} #{start_time}")
    end_time = DateTime.parse("#{date} #{end_time}") if end_time.present?

    Performance.find_or_create_by!(
      stage_id: stage.id,
      artist_id: artist.id,
      start_time:,
      end_time:
    )
  end
end

task tag_artists_with_genres: :environment do
  JSON.parse(File.read('lib/assets/artist_genres.json')).each do |artist_name, genres|
    artist = Artist.find_by(name: artist_name)
    genres.map do |genre|
      tag = Tag.genres.find_or_create_by(name: genre, category: 'music', sub_category: 'genre')
      TaggedItem.find_or_create_by(taggable: artist, tag_id: tag.id)
    end
  end
end

task tag_all_artists_with_two_genres: :environment do
  Artist.all.each do |artist|
    artist.tags << Tag.genres.sample(1) if artist.tags.count < 2
    artist.tags << Tag.genres.sample(1) if artist.tags.reload.count < 2
  end
end

tag fill_in_artist_info: :environment do
  Artist.all.each do |artist|
    artist.bio = Faker::Lorem.paragraphs(number: 3) if artist.bio.nil?
    artist.tagline = Faker::Lorem.sentence(word_count: 3) if artist.tagline.nil?
    artist.save
  end
end
