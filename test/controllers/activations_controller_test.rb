require "test_helper"

class ActivationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @activation = activations(:one)
  end

  test "should get index" do
    get activations_url
    assert_response :success
  end

  test "should get new" do
    get new_activation_url
    assert_response :success
  end

  test "should create activation" do
    assert_difference("Activation.count") do
      post activations_url, params: { activation: { description: @activation.description, image: @activation.image, name: @activation.name, social_media_links: @activation.social_media_links, website: @activation.website } }
    end

    assert_redirected_to activation_url(Activation.last)
  end

  test "should show activation" do
    get activation_url(@activation)
    assert_response :success
  end

  test "should get edit" do
    get edit_activation_url(@activation)
    assert_response :success
  end

  test "should update activation" do
    patch activation_url(@activation), params: { activation: { description: @activation.description, image: @activation.image, name: @activation.name, social_media_links: @activation.social_media_links, website: @activation.website } }
    assert_redirected_to activation_url(@activation)
  end

  test "should destroy activation" do
    assert_difference("Activation.count", -1) do
      delete activation_url(@activation)
    end

    assert_redirected_to activations_url
  end
end
