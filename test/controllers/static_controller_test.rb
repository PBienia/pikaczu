require 'test_helper'

class StaticControllerTest < ActionDispatch::IntegrationTest
  test "should get manual" do
    get static_manual_url
    assert_response :success
  end

end
