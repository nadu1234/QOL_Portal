class RemoveBodyMiddleAndBottomFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :body_middle, :text
    remove_column :posts, :body_bottom, :text
  end
end
