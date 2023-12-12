class RenameBodyTopToExplanationInPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :body_top, :explanation
  end
end
