require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:test_user)
  end

  test "logging in updates session with user_id" do
    log_in(@user)
    assert_equal @user.id, session[:user_id]
  end

  test "remembering sets remember digest to not nil" do
    remember(@user)
    assert_not_nil @user.remember_digest
  end

  test "remembering keeps user id in session" do
    remember(@user)
    assert_equal @user.id, cookies.permanent.signed[:user_id]
  end

  test "remembering keeps remember_token in session" do
    remember(@user)
    assert_equal @user.remember_token, cookies.permanent[:remember_token]
  end

  test "forgetting sets remember digest to nil" do
    remember(@user)
    forget(@user)
    assert_nil @user.remember_digest
  end

  test "forgetting deletes user_id from cookie" do
    remember(@user)
    forget(@user)
    assert_nil cookies[:user_id]
  end

  test "forgetting deletes the remember token from cookie" do
    remember(@user)
    forget(@user)
    assert_nil cookies[:remember_token]
  end

  test "current_user returns right user when session is nil" do
    log_in(@user)
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test "current_user returns nil when remember digest is wrong" do
    remember(@user)
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end

  test "return true if user is current user" do
    log_in(@user)
    assert current_user?(@user)
  end

  test "if logged in, return true" do
    log_in(@user)
    assert logged_in?
  end

  test "if not logged in, return false" do
    assert_not logged_in?
  end

  test "logging out deletes user id from session" do
    remember(@user)
    log_out
    assert_nil session[:user_id]
  end

  test "logging out deletes current_user" do
    remember(@user)
    log_out
    assert_nil current_user
  end

end