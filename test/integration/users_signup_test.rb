require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "", email: "invalid",
                                        password: "a", password_confirmation: "b" } }
    end

    assert_template "users/new"
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    assert_select 'form[action="/signup"]'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "test", email: "test@gmail.com",
                                         password: "Test123", password_confirmation: "Test123" }}

    end

    follow_redirect!
    assert_template "users/show"
    assert is_logged_in?
    assert_not flash.empty?

  end
end