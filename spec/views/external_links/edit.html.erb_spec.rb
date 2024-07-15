require 'rails_helper'

RSpec.describe "external_links/edit", type: :view do
  let(:external_link) {
    ExternalLink.create!(
      url: "MyString",
      link_type: "MyString",
      linkable: nil
    )
  }

  before(:each) do
    assign(:external_link, external_link)
  end

  it "renders the edit external_link form" do
    render

    assert_select "form[action=?][method=?]", external_link_path(external_link), "post" do

      assert_select "input[name=?]", "external_link[url]"

      assert_select "input[name=?]", "external_link[link_type]"

      assert_select "input[name=?]", "external_link[linkable_id]"
    end
  end
end
