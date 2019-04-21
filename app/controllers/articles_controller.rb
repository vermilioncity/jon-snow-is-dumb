class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:success] = 'Article posted!'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update_attributes(article_params)
      flash[:success] = "Article successfully updated!"
      redirect_to article_path(@article)
    else
      flash[:warning] = "Couldn't update article"
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "Article was successfully deleted"
    redirect_to articles_path
  end

  def index
    @articles = Article.list_articles(search_params[:search]).paginate(page: params[:page], per_page: 10)
  end

  private
    def article_params
      params.require(:article).permit(:title, :content)
    end

    def search_params
      params.permit(:search, :utf8)
    end

    def set_article
      @article = Article.find(params[:id])
    end
end