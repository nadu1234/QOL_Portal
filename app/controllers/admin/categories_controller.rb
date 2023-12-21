class Admin::CategoriesController < ApplicationController
  
  def index
    @category = Category.new
    @categories = Category.all
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: "カテゴリを作成しました。"
    else
      @categories = Category.all
      # flash.now[:notice] = "カテゴリ作成に失敗しました。"
      render 'index'
    end
  end
  
  def edit
    @category = Category.find(params[:id])
    @category_name = flash[:category_name] || @category.category_name
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "カテゴリを変更しました。"
    else
      session[:error_message] = @category.errors.full_messages
      flash[:category_name] = @category.category_name
      redirect_to edit_admin_category_path(@category)
    end
  end
  
  private

  def category_params
    params.require(:category).permit(:category_name)
  end
  
end
