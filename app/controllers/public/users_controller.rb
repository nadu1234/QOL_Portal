class Public::UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to request.referer, notice: "変更を保存しました"
    else
      render :edit
    end
  end
  
  def withdraw
    @user = User.find_by(id: params[:id])
    @user.update(is_active: false)
    reset_session
    redirect_to root_path
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :profile, :profile_image)
  end
    
end
