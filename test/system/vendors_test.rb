require "application_system_test_case"

class VendorsTest < ApplicationSystemTestCase
  setup do
    @vendor = vendors(:one)
  end

  test "visiting the index" do
    visit vendors_url
    assert_selector "h1", text: "Vendors"
  end

  test "should create vendor" do
    visit vendors_url
    click_on "New vendor"

    fill_in "Category", with: @vendor.category
    fill_in "Cuisine type", with: @vendor.cuisine_type
    fill_in "Description", with: @vendor.description
    fill_in "Image", with: @vendor.image
    fill_in "Name", with: @vendor.name
    fill_in "Social media links", with: @vendor.social_media_links
    fill_in "Website", with: @vendor.website
    click_on "Create Vendor"

    assert_text "Vendor was successfully created"
    click_on "Back"
  end

  test "should update Vendor" do
    visit vendor_url(@vendor)
    click_on "Edit this vendor", match: :first

    fill_in "Category", with: @vendor.category
    fill_in "Cuisine type", with: @vendor.cuisine_type
    fill_in "Description", with: @vendor.description
    fill_in "Image", with: @vendor.image
    fill_in "Name", with: @vendor.name
    fill_in "Social media links", with: @vendor.social_media_links
    fill_in "Website", with: @vendor.website
    click_on "Update Vendor"

    assert_text "Vendor was successfully updated"
    click_on "Back"
  end

  test "should destroy Vendor" do
    visit vendor_url(@vendor)
    click_on "Destroy this vendor", match: :first

    assert_text "Vendor was successfully destroyed"
  end
end