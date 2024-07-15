require 'rails_helper'

RSpec.describe "external_links/new", type: :view do
  before(:each) do
    assign(:external_link, ExternalLink.new(
      url: "MyString",
      link_type: "MyString",
      linkable: nil
    ))
  end

  it "renders new external_link form" do
    render

    assert_select "form[action=?][method=?]", external_links_path, "post" do

      assert_select "input[name=?]", "external_link[url]"

      assert_select "input[name=?]", "external_link[link_type]"

      assert_select "input[name=?]", "external_link[linkable_id]"
    end
  end
end
