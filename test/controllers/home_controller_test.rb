require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get confirmation" do
    get home_confirmation_url
    assert_response :success
  end

end
