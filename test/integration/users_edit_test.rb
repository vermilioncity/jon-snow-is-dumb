require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test_user)
    log_in_as(@user)
    get edit_user_path(@user)
  end

  test "unsuccessful edit with friendly forwarding" do
    patch user_path(@user), params: { user: { email: "foo@invalid",
                                              password: "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
    assert_select 'div.panel.panel-danger'
    assert_select 'div.panel-body > ul > li'

  end

  test "successful edit with no password" do
    email = "another@email.com"
    patch user_path(@user), params: { user: { email: email,
                                              password: "",
                                              confirmation_password: ""} }

    assert_not flash.empty?
    assert_redirected_to root_path
    @user.reload
    assert_equal email, @user.email
  end

end