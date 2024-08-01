# == Schema Information
#
# Table name: embedded_contents
#
#  id              :uuid             not null, primary key
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
FactoryBot.define do
  factory :embedded_content do
    url { "MyString" }
    content_type { "MyString" }
    title { "MyString" }
    embed_code { "MyText" }
    description { "MyText" }
    embeddable { nil }
  end
end
