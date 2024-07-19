require_relative '../../app/services/s3_uploader'

namespace :uploads do
  task upload_to_s3: :environment do
    artists_data = [
      { file_name: 'abby_hamilton.png', artist_name: 'Abby Hamilton' },
      { file_name: 'abigail_dowd.png', artist_name: 'Abigale Dowd' },
      { file_name: 'bio_ritmo.png', artist_name: 'BioRitmo' },
      { file_name: 'blue_ridge_girls.png', artist_name: 'Blue Ridge Girls' },
      { file_name: 'caique_vidal_batuque.png', artist_name: 'Caique Vidal & Batuque' },
      { file_name: 'candice_ivory_ensemble.png', artist_name: 'Candice Ivory Ensemble' },
      { file_name: 'colin_cutler_hot_pepper_jam.png', artist_name: 'Colin Cutler & Hot Pepper Jam' },
      { file_name: 'dashawn_hickman_presents_sacred_steel_featuring_wendy_hickman.png',
        artist_name: 'DeShawn Hickman Presents Sacred Steel, feat Wendy Hickman' },
      { file_name: 'demeanor.png', artist_name: 'Demeanor' },
      { file_name: 'drew_foust_the_wheelhouse.png', artist_name: 'Drew Foust & The Wheelhouse' },
      { file_name: 'elias_alexander.png', artist_name: 'Elias Alexander' },
      { file_name: 'emanuel_wynter.png', artist_name: 'Emanuel Wynter' },
      { file_name: 'ethno_usa.png', artist_name: 'Ethno USA' },
      { file_name: 'holler_choir.png', artist_name: 'Holler Choir' },
      { file_name: 'jon_muq.png', artist_name: 'Jon Muq' },
      { file_name: 'lakota_john.png', artist_name: 'Lakota John' },
      { file_name: 'los_lonely_boys.png', artist_name: 'Los Lonely Boys' },
      { file_name: 'mipso.png', artist_name: 'Mipso' },
      { file_name: 'old_heavy_hands.png', artist_name: 'Old Heavy Hands' },
      { file_name: 'olive_klug.png', artist_name: 'Olive Klug' },
      { file_name: 'oxente.png', artist_name: 'Oxente' },
      { file_name: 'rissi_palmer.png', artist_name: 'Rissi Palmer' },
      { file_name: 'sam_fribush_organ_trio_featuring_calvin_napper_and_charlie_hunter.png',
        artist_name: 'Sam Fribush Organ Trio' },
      { file_name: 'she_returns_from_war.png', artist_name: 'She Returns from War' },
      { file_name: 'susto.png', artist_name: 'Susto' },
      { file_name: 'tae_lewis.png', artist_name: 'Tae Lewis' },
      { file_name: 'the_psycodelics.png', artist_name: 'Psycodelics' },
      { file_name: 'the_war_treaty.png', artist_name: 'The War & Treaty' },
      { file_name: 'unheard_project.png', artist_name: 'Unheard Project' },
      { file_name: 'wild_roots.png', artist_name: 'Wild Roots' }
    ]

    s3_uploader = S3Uploader.new('gcs-ncff')

    Dir.glob(Rails.root.join('app', 'assets', 'images', 'artist_card_images', '*')).each do |file_path|
      next if File.directory?(file_path)

      file_name = File.basename(file_path)
      file_size = File.size(file_path)
      content_type = Marcel::MimeType.for(Pathname.new(file_path))

      artist = Artist.find_by_name(artists_data.find { |hash| hash[:file_name] == file_name }[:artist_name])
      next if artist.uploads.where(image_type: 'primary').exists?

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
        upload.uploadable = artist
        upload.image_type = 'primary'
        upload.save!

        puts "Uploaded #{file_name} to S3 and created Upload record"
      else
        puts "Failed to upload #{file_name} to S3"
      end
    end
  end
end
