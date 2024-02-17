class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(8)
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
    if @user.email == "guest@example.com"
      flash[:notice] = "ゲストユーザーは退会できません。"
    else
      @user.update(is_active: false)
      reset_session
      flash[:notice] = "退会されました。"
    end
    redirect_to root_path
  end

  def favorite
    favorite = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @favorite_posts = Post.post_user_active.where(id: favorite).page(params[:page]).per(8)
  end

  def follows
    user = User.find(params[:id])
    @users = user.follow_user.active.page(params[:page]).per(8)
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_user.active.page(params[:page]).per(8)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile, :profile_image)
  end

end
