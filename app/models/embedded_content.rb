# == Schema Information
#
# Table name: embedded_contents
#
#  id              :bigint           not null, primary key
#  url             :string
#  content_type    :string
#  title           :string
#  embed_code      :text
#  description     :text
#  embeddable_type :string           not null
#  embeddable_id   :uuid             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
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
