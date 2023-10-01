require "test_helper"

class FriendshipTokensControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get friendship_tokens_show_url
    assert_response :success
  end
end
