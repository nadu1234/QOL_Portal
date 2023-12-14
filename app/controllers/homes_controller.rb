class HomesController < ApplicationController
  def top
    @posts_release = Post.is_release.order(created_at: :desc)
    @categories = Category.all
    @tags = Tag.all

    # パラメーターから選択されたカテゴリとタグを取得
    @selected_category = params[:category]
    @selected_tags = params[:tags]

    # 選択された条件に基づいて投稿をフィルタリング
    @posts = if @selected_tags.present? && @selected_category.present?
               @posts_release.filter_by_category_and_tags(@selected_category, @selected_tags)
             elsif @selected_category.present? && @selected_tags.blank?
               @posts_release.filter_by_category(@selected_category)
             elsif @selected_tags.present? && @selected_category.blank?
               @posts_release.filter_by_tags(@selected_tags)
             else
               @posts_release
             end

  end
end
