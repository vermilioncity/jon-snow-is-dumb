require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test_user)
    @other_user = users(:della_user)
    @inactive_user = users(:inactive_user)
    ActionMailer::Base.deliveries.clear
    @signup_params = { user: { username: 'a',
                               email: 'a@a.com',
                               password: 'Password123',
                               password_confirmation: 'Password123' } }
  end

  test "should get new" do
    get new_user_path
    assert_response :success
  end

  test "should get create" do
    get signup_path
    assert_response :success
  end

  test "should redirect back to root when create params ok" do
    post signup_path, params: @signup_params
    assert_redirected_to root_path
  end

  test "should flash success when create params ok" do
    post signup_path, params: @signup_params
    assert_not flash.empty?
  end


  test "should deliver message when create params ok" do
    post signup_path, params: @signup_params
    assert_equal 1, ActionMailer::Base.deliveries.size

  end


  test "should render new when failing to create new user" do
    post signup_path, params: { user: { username: 'a',
                                        email: 'a@a.com',
                                        password: 'Password123',
                                        password_confirmation: '' } }
    assert_template 'new'

  end

  test "should get edit if user activated and logged in" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_response :success
  end

  test "should redirect to root if user not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url(assigns(:user))
  end

  test "should redirect update if user not logged in" do
    patch user_path(@user), params: { user: { username: @user.username,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should not allow the admin attribute to be edited via the web" do

    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
        user: { password: 'password',
                password_confirmation: 'password',
                admin: true } }

    assert_nil @other_user.admin
  end

  test "admin should be able to delete other users" do
    assert_difference 'User.count', -1 do
      log_in_as(@user)
      delete user_path(@other_user)
    end
  end

  test "non-admins shouldn't be able to delete other users" do
    assert_no_difference 'User.count' do
      log_in_as(@other_user)
      delete user_path(@user)
    end
  end

  test "non-admins get redirected when trying to delete users" do
    log_in_as(@other_user)
    delete user_path(@user)
    assert_redirected_to root_path
  end


end
