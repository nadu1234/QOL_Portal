class Admin::TagsController < ApplicationController

  def index
    @tag = Tag.new
    @tags = Tag.all
    @tag_name = flash[:tag_name] || @tag.tag_name
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to admin_tags_path, notice: "タグを作成しました。"
    else
      session[:error_message] = @tag.errors.full_messages
      @tags = Tag.all
      # flash.now[:notice] = "タグ作成に失敗しました。"
      render 'index'
    end
  end

  def edit
    @tag = Tag.find(params[:id])
    @tag_name = flash[:tag_name] || @tag.tag_name
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to admin_tags_path
    else
      session[:error_message] = @tag.errors.full_messages
      flash[:tag_name] = @tag.tag_name
	    redirect_to edit_admin_tag_path(@tag)
    end
  end

  def destroy
    tag = Tag.find(params[:id])  # データ（レコード）を1件取得
    tag.destroy  # データ（レコード）を削除
    redirect_to admin_tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:tag_name)
  end

end
