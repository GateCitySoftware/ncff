require "application_system_test_case"

class TaggedItemsTest < ApplicationSystemTestCase
  setup do
    @tagged_item = tagged_items(:one)
  end

  test "visiting the index" do
    visit tagged_items_url
    assert_selector "h1", text: "Tagged items"
  end

  test "should create tagged item" do
    visit tagged_items_url
    click_on "New tagged item"

    fill_in "Tag", with: @tagged_item.tag_id
    fill_in "Taggable", with: @tagged_item.taggable_id
    fill_in "Taggable type", with: @tagged_item.taggable_type
    click_on "Create Tagged item"

    assert_text "Tagged item was successfully created"
    click_on "Back"
  end

  test "should update Tagged item" do
    visit tagged_item_url(@tagged_item)
    click_on "Edit this tagged item", match: :first

    fill_in "Tag", with: @tagged_item.tag_id
    fill_in "Taggable", with: @tagged_item.taggable_id
    fill_in "Taggable type", with: @tagged_item.taggable_type
    click_on "Update Tagged item"

    assert_text "Tagged item was successfully updated"
    click_on "Back"
  end

  test "should destroy Tagged item" do
    visit tagged_item_url(@tagged_item)
    click_on "Destroy this tagged item", match: :first

    assert_text "Tagged item was successfully destroyed"
  end
end
