require 'rails_helper'

RSpec.describe "favorites/edit", type: :view do
  let(:favorite) {
    Favorite.create!(
      user: nil,
      item: nil
    )
  }

  before(:each) do
    assign(:favorite, favorite)
  end

  it "renders the edit favorite form" do
    render

    assert_select "form[action=?][method=?]", favorite_path(favorite), "post" do

      assert_select "input[name=?]", "favorite[user_id]"

      assert_select "input[name=?]", "favorite[item_id]"
    end
  end
end
