require "test_helper"

class TaggedItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tagged_item = tagged_items(:one)
  end

  test "should get index" do
    get tagged_items_url
    assert_response :success
  end

  test "should get new" do
    get new_tagged_item_url
    assert_response :success
  end

  test "should create tagged_item" do
    assert_difference("TaggedItem.count") do
      post tagged_items_url, params: { tagged_item: { tag_id: @tagged_item.tag_id, taggable_id: @tagged_item.taggable_id, taggable_type: @tagged_item.taggable_type } }
    end

    assert_redirected_to tagged_item_url(TaggedItem.last)
  end

  test "should show tagged_item" do
    get tagged_item_url(@tagged_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_tagged_item_url(@tagged_item)
    assert_response :success
  end

  test "should update tagged_item" do
    patch tagged_item_url(@tagged_item), params: { tagged_item: { tag_id: @tagged_item.tag_id, taggable_id: @tagged_item.taggable_id, taggable_type: @tagged_item.taggable_type } }
    assert_redirected_to tagged_item_url(@tagged_item)
  end

  test "should destroy tagged_item" do
    assert_difference("TaggedItem.count", -1) do
      delete tagged_item_url(@tagged_item)
    end

    assert_redirected_to tagged_items_url
  end
end
