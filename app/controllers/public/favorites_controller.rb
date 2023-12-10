class Public::FavoritesController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    favorite = Favorite.new(post_id: @post.id)
    favorite.user_id = current_user.id
    favorite.save
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)#現在のユーザーのすべてのお気に入りを取得しさらにfind_byで投稿IDとparamsで取得したIDが同じものを検索。
    favorite.destroy
  end
  
end
