class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:index, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(signup_user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(edit_user_params)
      flash[:success] = 'Successfully updated!'
      if edit_user_params.key?(:avatar)
        render 'edit'
      else
        redirect_to root_url
      end
    else
      raise()
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_url
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  private

    def signup_user_params
      params.require(:user).permit(:username, :email, :password,
                                   :password_confirmation)
    end

    def edit_user_params
      params.require(:user).permit(:email, :password,
                                   :password_confirmation,
                                   :avatar)
    end

end
