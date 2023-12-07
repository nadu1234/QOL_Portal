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
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "カテゴリを変更しました。"
    else
      render "edit"
    end
  end
  
  private

  def category_params
    params.require(:category).permit(:category_name)
  end
  
end
