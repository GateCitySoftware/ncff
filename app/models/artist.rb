# frozen_string_literal: true

class Artist < ApplicationRecord
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
