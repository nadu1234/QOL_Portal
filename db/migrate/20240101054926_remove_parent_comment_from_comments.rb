class RemoveParentCommentFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :parent_comment_id
  end
end
