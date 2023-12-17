class HomesController < ApplicationController
  def top
    @posts_release = Post.is_release_and_active
    @categories = Category.all
    @tags = Tag.all

    # パラメーターから選択されたカテゴリとタグを取得
    @selected_category = params[:category]
    @selected_tags = params[:tags]

    @sort_order = params[:sort_order].presence || 'desc'
    
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
             
    case @sort_order
    when 'desc'
      @posts = @posts.order(created_at: :desc)
    when 'asc'
      @posts = @posts.order(created_at: :asc)
    when 'favorites'
      @posts = @posts.order_by_favorites
    when 'comments'
      @posts = @posts.order_by_comments
    else
      @posts = @posts.order(created_at: :desc)
    end
  end
end
