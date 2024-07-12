require "application_system_test_case"

class MerchantsTest < ApplicationSystemTestCase
  setup do
    @merchant = merchants(:one)
  end

  test "visiting the index" do
    visit merchants_url
    assert_selector "h1", text: "Merchants"
  end

  test "should create merchant" do
    visit merchants_url
    click_on "New merchant"

    fill_in "Description", with: @merchant.description
    fill_in "Image", with: @merchant.image
    fill_in "Name", with: @merchant.name
    fill_in "Product type", with: @merchant.product_type
    fill_in "Social media links", with: @merchant.social_media_links
    fill_in "Website", with: @merchant.website
    click_on "Create Merchant"

    assert_text "Merchant was successfully created"
    click_on "Back"
  end

  test "should update Merchant" do
    visit merchant_url(@merchant)
    click_on "Edit this merchant", match: :first

    fill_in "Description", with: @merchant.description
    fill_in "Image", with: @merchant.image
    fill_in "Name", with: @merchant.name
    fill_in "Product type", with: @merchant.product_type
    fill_in "Social media links", with: @merchant.social_media_links
    fill_in "Website", with: @merchant.website
    click_on "Update Merchant"

    assert_text "Merchant was successfully updated"
    click_on "Back"
  end

  test "should destroy Merchant" do
    visit merchant_url(@merchant)
    click_on "Destroy this merchant", match: :first

    assert_text "Merchant was successfully destroyed"
  end
end
