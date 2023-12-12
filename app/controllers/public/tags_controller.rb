class Public::TagsController < ApplicationController
  
  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.is_release
  end
  
end
