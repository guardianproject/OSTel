require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get suggest" do
    get :suggest
    assert_response :success
  end

  test "should get link" do
    get :link
    assert_response :success
  end

end
