class CommentsController < ApplicationController
  before_action :find_article
  before_action :correct_user_or_admin, only: [:update, :destroy]

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user_id = current_user.id if current_user || nil
    if @comment.save
      redirect_to article_path(@article)
    else
      raise
    end
  end

  def update
    @comment = @article.comments.build(comment_params)
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @user = User.find(@comment.user_id)

    if correct_user_or_admin?(@user)
      @comment.destroy
      flash[:success] = "Comment was successfully deleted"
    end
  end

  def index
    @comments = @article.comments.order(created_at: :desc)
  end

  private

    def find_article
      @article = Article.find_by_id(params[:article_id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end

end