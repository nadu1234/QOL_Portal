class HomesController < ApplicationController
  def top
    @posts = Post.where(is_release: true).order(created_at: :desc)
  end
end
