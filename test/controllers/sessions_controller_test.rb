require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_user)
    @inactive_user = users(:inactive_user)
  end

  test "should get new" do
    get login_path
    assert_response :success
  end

  test "authenticated and activated user gets logged in" do
    get login_path
    post login_path, params: { session: { username: @user.username, password: 'password' } }
    assert is_logged_in?
  end

  test "authenticated and activated user who checks off remember is remembered in session" do
    get login_path
    post login_path, params: { session: { username: @user.username, password: 'password', remember_me: '1' } }
    assert_not_nil @user.reload.remember_digest
  end

  test "authenticated and activated user who does not check off remember is not remembered in session" do
    get login_path
    post login_path, params: { session: { username: @user.username, password: 'password', remember_me: '0' } }
    assert_nil @user.reload.remember_digest
  end

  test "authenticated and activated user redirected after logging in" do
    get login_path
    post login_path, params: { session: { username: @user.username, password: 'password', remember_me: '1' } }
    assert_redirected_to root_path
  end

  test "unactivated users redirected when attempting to log in" do
    get login_path
    post login_path, params: { session: { username: @inactive_user.username, password: 'password', remember_me: '1' } }
    assert_redirected_to root_path
  end

  test "unactivated users get a warning when attempting to log in" do
    get login_path
    post login_path, params: { session: { username: @inactive_user.username, password: 'password', remember_me: '1' } }
    assert_not flash.empty?
  end

  test "invalid username/password gets a warning when attempting to log in" do
    get login_path
    post login_path, params: { session: { username: @inactive_user.username, password: 'wrong', remember_me: '1' } }
    assert_not flash.empty?
  end

  test "invalid username/password redirected when attempting to log in" do
    get login_path
    post login_path, params: { session: { username: @inactive_user.username, password: 'wrong', remember_me: '1' } }
    assert_template'new'
  end

end