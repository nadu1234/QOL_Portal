class Admin::UsersController < ApplicationController
  before_action :is_matching_login_admin, only: [:index, :edit, :update]
  
  def index
    @users = User.all.page(params[:page]).per(8)
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.toggle_active_status!
    redirect_to request.referer
  end
  
  private
  
  def post_params
    params.require(:user).permit(:is_active)
  end
  
  def is_matching_login_admin
    admin = current_admin
    unless admin && admin.email == "test@email"
      redirect_to root_path
    end
  end
  
end
