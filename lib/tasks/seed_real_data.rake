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

task fill_in_artist_info: :environment do
  Artist.all.each do |artist|
    artist.bio = Faker::Lorem.paragraph(sentence_count: 50).split('.').each_slice(10).map do |sentences|
      "<p>#{sentences.join('. ')}.</p>"
    end.join('')
    artist.tagline = Faker::Lorem.sentence(word_count: 3)
    artist.save
  end
end

task add_spotify_players: :environment do
  embed_codes = [
    '<iframe style="border-radius:12px" src="https://open.spotify.com/embed/artist/4TeKBLCqmYXzvcgYX4t4YA?utm_source=generator" width="100%" height="352" frameBorder="0" allowfullscreen="" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe>',
    '<iframe style="border-radius:12px" src="https://open.spotify.com/embed/playlist/37i9dQZF1DZ06evO1lW5tI?utm_source=generator" width="100%" height="352" frameBorder="0" allowfullscreen="" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe>',
    '<iframe style="border-radius:12px" src="https://open.spotify.com/embed/playlist/37i9dQZF1DZ06evO2GADwp?utm_source=generator" width="100%" height="352" frameBorder="0" allowfullscreen="" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe>',
    '<iframe style="border-radius:12px" src="https://open.spotify.com/embed/artist/7bQu41HtZVGGuRjLUnQYaZ?utm_source=generator" width="100%" height="352" frameBorder="0" allowfullscreen="" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe>',
    '<iframe style="border-radius:12px" src="https://open.spotify.com/embed/playlist/37i9dQZF1E4rpPB2i6w20m?utm_source=generator" width="100%" height="352" frameBorder="0" allowfullscreen="" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe>',
    '<iframe style="border-radius:12px" src="https://open.spotify.com/embed/album/1S6sk9yusYQoadSAbx3ZB8?utm_source=generator" width="100%" height="352" frameBorder="0" allowfullscreen="" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe>',
    '<iframe style="border-radius:12px" src="https://open.spotify.com/embed/playlist/37i9dQZF1DWYzpSJHStHHx?utm_source=generator" width="100%" height="352" frameBorder="0" allowfullscreen="" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe>',
    '<iframe style="border-radius:12px" src="https://open.spotify.com/embed/album/3RHJNmuwD0fnwccBv2HTif?utm_source=generator" width="100%" height="352" frameBorder="0" allowfullscreen="" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe>',
    '<iframe style="border-radius:12px" src="https://open.spotify.com/embed/artist/3NPZs8XgXtaWslUcnIw6rY?utm_source=generator" width="100%" height="352" frameBorder="0" allowfullscreen="" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe>',
    '<iframe style="border-radius:12px" src="https://open.spotify.com/embed/album/3ahHxtwRwMIdHcAo0MEXxX?utm_source=generator" width="100%" height="352" frameBorder="0" allowfullscreen="" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe>',
    '<iframe style="border-radius:12px" src="https://open.spotify.com/embed/playlist/37i9dQZF1DX9pryhDLql25?utm_source=generator" width="100%" height="352" frameBorder="0" allowfullscreen="" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe>'
  ]

  Artist.all.each do |artist|
    artist.embedded_contents.create!(
      embed_code: embed_codes.sample,
      url: 'https://www.youtube.com/watch?v=1234567890',
      content_type: 'Spotify Player',
      title: 'Placeholder Spotify Player - UPDATE ME',
      description: 'This is a placeholder Spotify Player. Please update this with a real one.'
    )
  end
end
