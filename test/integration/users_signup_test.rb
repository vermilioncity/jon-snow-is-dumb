require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "valid signup information with account activation" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "test", email: "test@gmail.com",
                                         password: "Test123", password_confirmation: "Test123" } }

    end

    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?

    # Try to log in before activation.
    log_in_as(user)
    assert_not is_logged_in?

    # Invalid activation token
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?

    # Valid token, wrong email
    get edit_account_activation_path(user.activation_token, email: "wrong email")
    assert_not is_logged_in?

    # Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert is_logged_in?
    assert user.reload.activated?

    follow_redirect!
    assert_template'articles/index'
    assert is_logged_in?

  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "", email: "test@gmail.com",
                                         password: "Test123", password_confirmation: "Test123" } }
    end
    assert_template "users/new"
    assert_select 'div.panel.panel-danger'
    assert_select 'div.panel-body > ul > li'
  end
end