class Public::CategoriesController < ApplicationController
  
  def show
    @category = Category.find(params[:id])
    @posts = @category.posts.is_release
  end
  
end
