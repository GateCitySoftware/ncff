# == Schema Information
#
# Table name: tagged_items
#
#  id            :bigint           not null, primary key
#  tag_id        :bigint           not null
#  taggable_type :string           not null
#  taggable_id   :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class TaggedItem < ApplicationRecord
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
end
