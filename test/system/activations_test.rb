require "application_system_test_case"

class ActivationsTest < ApplicationSystemTestCase
  setup do
    @activation = activations(:one)
  end

  test "visiting the index" do
    visit activations_url
    assert_selector "h1", text: "Activations"
  end

  test "should create activation" do
    visit activations_url
    click_on "New activation"

    fill_in "Description", with: @activation.description
    fill_in "Image", with: @activation.image
    fill_in "Name", with: @activation.name
    fill_in "Social media links", with: @activation.social_media_links
    fill_in "Website", with: @activation.website
    click_on "Create Activation"

    assert_text "Activation was successfully created"
    click_on "Back"
  end

  test "should update Activation" do
    visit activation_url(@activation)
    click_on "Edit this activation", match: :first

    fill_in "Description", with: @activation.description
    fill_in "Image", with: @activation.image
    fill_in "Name", with: @activation.name
    fill_in "Social media links", with: @activation.social_media_links
    fill_in "Website", with: @activation.website
    click_on "Update Activation"

    assert_text "Activation was successfully updated"
    click_on "Back"
  end

  test "should destroy Activation" do
    visit activation_url(@activation)
    click_on "Destroy this activation", match: :first

    assert_text "Activation was successfully destroyed"
  end
end
