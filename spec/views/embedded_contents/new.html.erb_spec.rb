require 'rails_helper'

RSpec.describe "embedded_contents/new", type: :view do
  before(:each) do
    assign(:embedded_content, EmbeddedContent.new(
      url: "MyString",
      content_type: "MyString",
      title: "MyString",
      embed_code: "MyText",
      description: "MyText",
      embeddable: nil
    ))
  end

  it "renders new embedded_content form" do
    render

    assert_select "form[action=?][method=?]", embedded_contents_path, "post" do

      assert_select "input[name=?]", "embedded_content[url]"

      assert_select "input[name=?]", "embedded_content[content_type]"

      assert_select "input[name=?]", "embedded_content[title]"

      assert_select "textarea[name=?]", "embedded_content[embed_code]"

      assert_select "textarea[name=?]", "embedded_content[description]"

      assert_select "input[name=?]", "embedded_content[embeddable_id]"
    end
  end
end
