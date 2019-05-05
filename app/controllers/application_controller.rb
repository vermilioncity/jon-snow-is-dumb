class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def correct_user_or_admin
      @user = User.find_by(id: session[:user_id])
      unless correct_user_or_admin?(@user)
        flash[:warning] = "Insufficient permissions to do this action"
      end
    end

end
