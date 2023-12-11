class Public::RelationshipsController < ApplicationController
  
  # フォローするとき
  def create
    @user = User.find(params[:user_id])
    current_user.is_follow(params[:user_id])
    # redirect_to request.referer
  end
  
  # フォロー外すとき
  def destroy
    @user = User.find(params[:user_id])
    current_user.is_unfollow(params[:user_id])
    # redirect_to request.referer  
  end
  
end
