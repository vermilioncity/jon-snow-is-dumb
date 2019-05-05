require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_user)
    log_in_as(@user)

    @valid_params = { article: { title: 'a', content: 'a' * 300 } }
    @invalid_params = { article: { title: 'a', content: '' } }
    @article = articles(:test_article)
  end

  test "should get new" do
    get new_article_path
    assert_response :success
  end

  test "should get show" do
    get article_path(@article)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_path(@article)
    assert_response :success
  end

  test "should get index if no params" do
    get articles_path
    assert_response :success
  end

  test "should get index if params" do
    get articles_path, params: { search: 'ruby' }
    assert_response :success
  end

  test "create saves a new article if valid params" do
    assert_difference 'Article.count', 1 do
      post articles_path, params: @valid_params
    end
  end

  test "create flashes success if valid params" do
    post articles_path, params: @valid_params
    assert_not flash.empty?
  end

  test "create redirects to new article if valid params" do
    post articles_path, params: @valid_params
    @article = assigns(:article)
    assert_redirected_to article_path(@article)
  end

  test "create renders new if invalid params" do
    post articles_path, params: @invalid_params
    assert_template 'articles/new'
  end

  test "create flashes error if invalid params" do
    post articles_path, params: @invalid_params
    assert_select 'div.panel.panel-danger'
    assert_select 'div.panel-body > ul > li'
  end

  test 'update flashes success if valid params' do
    patch article_path(@article), params: @valid_params
    assert_not flash.empty?
  end

  test 'update redirects to article if valid params' do
    patch article_path(@article), params: @valid_params
    assert_redirected_to article_path(@article)
  end

  test 'update flashes warning if invalid params' do
    patch article_path(@article), params: @invalid_params
    assert_not flash.empty?
  end

  test 'update re-renders edit if invalid params' do
    patch article_path(@article), params: @invalid_params
    assert_template 'edit'
  end

  test 'destroy deletes the article' do
    assert_difference 'Article.count', -1 do
      delete article_path(@article)
    end
  end

  test 'destroy flashes upon success' do

  end

  test 'destroy redirects to index after deleting' do

  end

end