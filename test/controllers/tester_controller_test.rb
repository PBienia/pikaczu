require 'test_helper'

class TesterControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get tester_main_url
    assert_response :success
  end

  test "should get test" do
    get tester_test_url
    assert_response :success
  end

end
