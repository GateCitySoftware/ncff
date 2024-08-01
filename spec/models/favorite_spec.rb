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
require 'rails_helper'

RSpec.describe Favorite, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
