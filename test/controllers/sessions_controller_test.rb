
require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_url
    assert_response :success
  end

  test "should reject invalid login" do
    post login_url, params: {
      username: "wrong_user",
      password: "wrong_password"
    }

    assert_response :unprocessable_entity
  end
end
