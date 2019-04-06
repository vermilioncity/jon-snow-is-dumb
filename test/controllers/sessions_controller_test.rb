require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test should_get_new do
    get login_path
    assert_response :success
  end
end