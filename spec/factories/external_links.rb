# == Schema Information
#
# Table name: external_links
#
#  id            :uuid             not null, primary key
#  url           :string
#  link_type     :string
#  linkable_type :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  linkable_id   :uuid
#
FactoryBot.define do
  factory :external_link do
    url { "MyString" }
    link_type { "MyString" }
    linkable { nil }
  end
end
