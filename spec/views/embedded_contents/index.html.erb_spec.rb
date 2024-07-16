require 'rails_helper'

RSpec.describe "embedded_contents/index", type: :view do
  before(:each) do
    assign(:embedded_contents, [
      EmbeddedContent.create!(
        url: "Url",
        content_type: "Content Type",
        title: "Title",
        embed_code: "MyText",
        description: "MyText",
        embeddable: nil
      ),
      EmbeddedContent.create!(
        url: "Url",
        content_type: "Content Type",
        title: "Title",
        embed_code: "MyText",
        description: "MyText",
        embeddable: nil
      )
    ])
  end

  it "renders a list of embedded_contents" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Url".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Content Type".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
