require 'test_helper'

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_user)
    @valid_request_params = { password_reset: { email: @user.email } }
    @invalid_request_params = { password_reset: { email: 'hog' } }
    @valid_update_params = { email: @user.email,
                             user: { password: 'Password123',
                                     password_confirmation: 'Password123' } }
    ActionMailer::Base.deliveries.clear
  end

  test 'should get new' do
    get new_password_reset_path
    assert_response :success
  end

  test 'create reset digest if user exists' do
    @user.reset_digest = nil
    post password_resets_path, params: @valid_request_params
    assert_not_nil @user.reload.reset_digest
  end

  test 'create sends password email if user exists' do
    post password_resets_path, params: @valid_request_params
    assert_equal 1, ActionMailer::Base.deliveries.size
  end

  test 'create flashes successful email if user exists' do
    post password_resets_path, params: @valid_request_params
    assert_not flash.empty?
  end

  test 'create redirects to root if user exists' do
    post password_resets_path, params: @valid_request_params
    assert_redirected_to root_path
  end

  test 'create flashes warning if user does not exist' do
    post password_resets_path, params: @invalid_request_params
    assert_not flash.empty?
  end

  test 'create renders new if user does not exist' do
    post password_resets_path, params: @invalid_request_params
    assert_template 'new'
  end

  test 'update errors if password is empty' do
    patch password_reset_path('reset_token'),
          params: { email: @user.email, user: { password: '',
                                                password_confirmation: '' } }
    assert_select 'div.panel.panel-danger'
  end

  test 'update rerenders to edit if password empty' do
    patch password_reset_path('reset_token'),
          params: { email: @user.email, user: { password: '',
                                                password_confirmation: '' } }
    assert_template 'password_resets/edit'
  end

  test 'update logs user in if params valid' do
    patch password_reset_path('reset_token'), params: @valid_update_params
    assert is_logged_in?
  end

  test 'update resets reset digest if params valid' do
    patch password_reset_path('reset_token'), params: @valid_update_params
    assert_nil @user.reload.reset_digest
  end

  test 'update flashes success message if params valid' do
    patch password_reset_path('reset_token'), params: @valid_update_params
    assert_not flash.empty?
  end

  test 'update redirects to root url if params valid' do
    patch password_reset_path('reset_token'), params: @valid_update_params
    assert_redirected_to root_path
  end

  test 'update rerenders edit if email invalid' do
    patch password_reset_path('reset_token'),
          params: { email: 'wrong', user: { password: 'Password123',
                                            password_confirmation: 'Password132' } }
    assert_template 'password_resets/edit'
  end
  
  test 'update rerenders edit if password confirmation wrong' do
    patch password_reset_path('reset_token'),
          params: { email: @user.email, user: { password: 'Password123',
                                            password_confirmation: 'word132' } }
    assert_template 'password_resets/edit'
  end
end