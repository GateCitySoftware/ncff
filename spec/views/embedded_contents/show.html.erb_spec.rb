require 'rails_helper'

RSpec.describe "embedded_contents/show", type: :view do
  before(:each) do
    assign(:embedded_content, EmbeddedContent.create!(
      url: "Url",
      content_type: "Content Type",
      title: "Title",
      embed_code: "MyText",
      description: "MyText",
      embeddable: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/Content Type/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
