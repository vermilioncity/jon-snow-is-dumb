require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:test_user)
  end

  test 'password resets' do
    get new_password_reset_path
    assert_template 'password_resets/new'

    # invalid email
    post password_resets_path, params: { password_reset: { email: '' } }
    assert_not flash.empty?
    assert_template 'password_resets/new'

    # valid email
    post password_resets_path, params: { password_reset: { email: 'test@user.com' } }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url

    # Password reset form
    user = assigns(:user)

    # wrong email
    get edit_password_reset_path(user.reset_token, email: '')
    assert_redirected_to root_url

    # Inactive user
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url
    user.toggle!(:activated)

    # Right email, wrong token
    get edit_password_reset_path('bad_token', email: user.email)
    assert_redirected_to root_url

    # Right email, right token
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email

    # invalid password and confirmation
    patch password_reset_path(user.reset_token), params: { email: user.email,
                                                           user: { password: 'Baz123',
                                                                   password_confirmation: 'Bar123' } }

    assert_select 'div.panel.panel-danger'

    # empty password
    patch password_reset_path(user.reset_token), params: { email: user.email,
                                                           user: { password: '',
                                                                   password_confirmation: '' } }

    assert_select 'div.panel.panel-danger'

    # valid password and confirmation
    patch password_reset_path(user.reset_token),
          params: { email: user.email,
                    user: { password: 'Password123',
                            password_confirmation: 'Password123' } }

    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to root_path

  end

  test 'expired token' do
    get new_password_reset_path
    post password_resets_path, params: { password_reset: { email: @user.email } }
    @user = assigns(:user)
    @user.update_attribute(:reset_sent_at, 3.hours.ago)
    patch password_reset_path(@user.reset_token), params: { email: @user.email,
                                                            user: { password: 'Baz123',
                                                                    password_confirmation: 'Bar123' }}
    assert_not flash.empty?
    assert_redirected_to new_password_reset_url

    follow_redirect!
    assert_match /expired/i, response.body

  end
end
