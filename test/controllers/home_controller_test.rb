
require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should redirect to login when not authenticated" do
    get home_url

    assert_redirected_to login_url
  end
end
