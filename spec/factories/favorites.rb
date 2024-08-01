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
FactoryBot.define do
  factory :favorite do
    user { nil }
    item { nil }
  end
end
