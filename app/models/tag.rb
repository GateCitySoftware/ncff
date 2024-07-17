# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string
#  category   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :category }
  validates :category, presence: true

  has_many :tagged_items
  has_many :artists, through: :tagged_items, source: :taggable, source_type: 'Artist'

  scope :genres, -> { where(category: 'genre') }
  scope :cuisines, -> { where(category: 'cuisine') }
end
