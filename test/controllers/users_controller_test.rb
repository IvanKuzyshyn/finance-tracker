require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get portfolio" do
    get user_portfolio_url
    assert_response :success
  end

end
