# frozen_string_literal: true

# == Schema Information
#
# Table name: artists
#
#  id         :uuid             not null, primary key
#  name       :string
#  bio        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artist < ApplicationRecord
  include Sluggable

  sluggable_attributes :name

  GENRES = [
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
end
