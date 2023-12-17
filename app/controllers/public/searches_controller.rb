class Public::SearchesController < ApplicationController
  
  def search
    @posts = Post.search(params[:keyword])
  end
  
end
