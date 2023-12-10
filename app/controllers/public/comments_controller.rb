class Public::CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    @comment.save
    # redirect_to book_path(book)
  end

  def destroy
    @post = Post.find(params[:post_id])
    Comment.find(params[:id]).destroy
    # redirect_to book_path(params[:book_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end
