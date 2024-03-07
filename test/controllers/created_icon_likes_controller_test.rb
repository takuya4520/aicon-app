require "test_helper"

class CreatedIconLikesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get created_icon_likes_create_url
    assert_response :success
  end

  test "should get destroy" do
    get created_icon_likes_destroy_url
    assert_response :success
  end
end
