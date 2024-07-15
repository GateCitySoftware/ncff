require 'rails_helper'

RSpec.describe "external_links/index", type: :view do
  before(:each) do
    assign(:external_links, [
      ExternalLink.create!(
        url: "Url",
        link_type: "Link Type",
        linkable: nil
      ),
      ExternalLink.create!(
        url: "Url",
        link_type: "Link Type",
        linkable: nil
      )
    ])
  end

  it "renders a list of external_links" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Url".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Link Type".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
