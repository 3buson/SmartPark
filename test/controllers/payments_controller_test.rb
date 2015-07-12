require 'test_helper'

class PaymentsControllerTest < ActionController::TestCase
  test "should get client_token" do
    get :client_token
    assert_response :success
  end

  test "should get pay" do
    get :pay
    assert_response :success
  end

end
