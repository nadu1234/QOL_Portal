class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
    @categories = Category.all
    @tags = Tag.all
  end
  
  def show
    @post = Post.find(params[:id])
    @tags = @post.tags
  end
  
  def edit
    @post = Post.find(params[:id])
    @categories = Category.all
    @tags = Tag.all
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      @categories = Category.all
      @tags = Tag.all
      render 'new'
    end
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      @categories = Category.all
      @tags = Tag.all
      render "edit"
    end
  end
  
  def destroy
    post = post.find(params[:id])  
    post.destroy  
    redirect_to root_path
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :category_id, :top_image, :body_top, :middle_image, :body_middle, :bottom_image, :body_bottom, :is_release, tag_ids: [])
  end
  
end
