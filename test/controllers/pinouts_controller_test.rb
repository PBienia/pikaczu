require 'test_helper'

class PinoutsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pinouts_index_url
    assert_response :success
  end

  test "should get show" do
    get pinouts_show_url
    assert_response :success
  end

  test "should get new" do
    get pinouts_new_url
    assert_response :success
  end

  test "should get edit" do
    get pinouts_edit_url
    assert_response :success
  end

  test "should get create" do
    get pinouts_create_url
    assert_response :success
  end

end
