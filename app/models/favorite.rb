# == Schema Information
#
# Table name: favorites
#
#  id         :uuid             not null, primary key
#  user_id    :uuid             not null
#  item_type  :string           not null
#  item_id    :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :item, polymorphic: true
  has_paper_trail
end
