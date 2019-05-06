class PicturesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]

  def new
    @picture = Picture.new
  end

  def create
    @picture = current_user.articles.build(picture_params)
    if @picture.save
      flash[:success] = 'Picture posted!'
      redirect_to picture_path(@picture)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @picture.update_attributes(picture_params)
      flash[:success] = 'Picture updated!'
      redirect_to picture_path(@picture)
    else
      render 'edit'
    end
  end

  def show
  end

  def index
    Picture.all.paginate(page: params[:page], per_page: 20)
  end

  def destroy
    @picture.destroy
    flash[:notice] = "Article was successfully deleted"
    redirect_to pictures_path
  end

  private
    def set_article
      @picture = Picture.find(params[:id])
    end

    def picture_params
      params.require(:picture).permit(:picture, :description)
    end

end
