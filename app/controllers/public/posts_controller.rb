class Public::PostsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :is_matching_post_user, only: [:show]
  
  def new
    @post = Post.new
    @categories = Category.all
    @tags = Tag.all
  end
  
  def show
    @post = Post.find(params[:id])
    @post_active = @post.is_release
    @tags = @post.tags
    @comment = Comment.new
    @user = @post.user
    # @rakuten_items = RakutenWebService::Ichiba::Item.search(keyword: '布団')
  end
  
  def edit
    @post = Post.find(params[:id])
    @categories = Category.all
    @tags = Tag.all
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if post_params[:post_images].present?
      post_params[:post_images].each do |image|
        result = Vision.images_analysis(image)
        unless result
          @post.errors.add(:base, "不適切な画像が検出されたので投稿できません。")
          @categories = Category.all
          @tags = Tag.all
          render :new
          return
        end
      end
    end
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
  
    if post_params[:post_images].present?
      post_params[:post_images].each do |image|
        result = Vision.images_analysis(image)
        unless result
          @post.errors.add(:base, "不適切な画像が検出さたので保存できません。")
          @categories = Category.all
          @tags = Tag.all
          render "edit"
          return
        end
      end
    end
  
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      @categories = Category.all
      @tags = Tag.all
      render "edit"
    end
  end
  
  def destroy
    post = Post.find(params[:id])  
    post.destroy  
    redirect_to root_path
  end
  
  
  private
  
  def post_params
    params.require(:post).permit(:title, :category_id, :explanation, :is_release, post_images: [], tag_ids: [])
  end
  
  def is_matching_login_user
    post = Post.find(params[:id])
    unless post.user.id == current_user.id
      redirect_to root_path
    end
  end
  
  def is_matching_post_user
    post = Post.find(params[:id])
    if !post.is_release
      unless post.user.id == current_user.id
        redirect_to root_path
      end
    end
  end
  
end
