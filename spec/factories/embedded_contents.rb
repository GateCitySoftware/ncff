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
