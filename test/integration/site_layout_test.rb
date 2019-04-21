require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test 'layout links' do
    get root_path
    assert_template 'articles/index'
    assert_select 'a[href=?]', root_path, count: 1
    assert_select 'a[href=?]', about_path, count: 2
    assert_select 'a[href=?]', login_path, count: 1
    assert_select 'a[href=?]', projects_path, count: 2

    get about_path
    assert_select "title", full_title("About")

    get login_path
    assert_select "title", full_title("Login")

    get projects_path
    assert_select "title", full_title("Projects")

  end

end
