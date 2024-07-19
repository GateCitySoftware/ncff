# == Schema Information
#
# Table name: stage_schedules
#
#  id         :uuid             not null, primary key
#  name       :string
#  date       :date
#  stage_id   :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :stage_schedule do
    id { "" }
    name { "MyString" }
    date { "2024-07-17" }
    stage { nil }
  end
end
