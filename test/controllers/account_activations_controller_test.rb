require 'test_helper'

class AccountActivationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:inactive_user)
    @activation_token = 'activation'
  end

  test "activating an unactivated valid user sets them as activated" do
    get edit_account_activation_path(@activation_token, email: @user.email)
    assert @user.reload.activated, true
  end

  test "activating a user logs them in" do
    get edit_account_activation_path(@activation_token, email: @user.email)
    assert is_logged_in?
  end

  test "activating an authenticated user flashes success" do
    get edit_account_activation_path(@activation_token, email: @user.email)
    assert_not flash.empty?
  end

  test "successfully authenticating redirects to root_url" do
    get edit_account_activation_path(@activation_token, email: @user.email)
    assert_redirected_to root_url
  end

  test "trying to activate an already activated user flashes failure" do
    @user = users(:test_user)
    get edit_account_activation_path(@activation_token, email: @user.email)
    assert_not flash.empty?
  end

  test "trying to activate a user with a bad activation id flashes failure" do
    get edit_account_activation_path('bad_token', email: @user.email)
    assert_not flash.empty?
  end

  test "unsuccessfully authenticating redirects to root_url" do
    get edit_account_activation_path(@activation_token, email: 'bad_email')
    assert_redirected_to root_url
  end
end
