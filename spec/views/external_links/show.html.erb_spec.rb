require 'rails_helper'

RSpec.describe "external_links/show", type: :view do
  before(:each) do
    assign(:external_link, ExternalLink.create!(
      url: "Url",
      link_type: "Link Type",
      linkable: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/Link Type/)
    expect(rendered).to match(//)
  end
end
