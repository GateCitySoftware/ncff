require 'rails_helper'

RSpec.describe "favorites/index", type: :view do
  before(:each) do
    assign(:favorites, [
      Favorite.create!(
        user: nil,
        item: nil
      ),
      Favorite.create!(
        user: nil,
        item: nil
      )
    ])
  end

  it "renders a list of favorites" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
