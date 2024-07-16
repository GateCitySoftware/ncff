class EmbeddedContent < ApplicationRecord
  CONTENT_TYPES = [
    'YouTube Video',
    'Spotify Player',
    'SoundCloud Player',
    'Apple Music Player',
    'Bandcamp Player'
  ]

  validates :embeddable, :url, :title, :content_type, presence: true
  validates :content_type, inclusion: { in: CONTENT_TYPES }

  belongs_to :embeddable, polymorphic: true
end
