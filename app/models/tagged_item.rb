# == Schema Information
#
# Table name: tagged_items
#
#  id            :uuid             not null, primary key
#  tag_id        :uuid             not null
#  taggable_type :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  taggable_id   :uuid
#
class TaggedItem < ApplicationRecord
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
  validates_uniqueness_of :tag_id, scope: %i[taggable_id taggable_type]
end
