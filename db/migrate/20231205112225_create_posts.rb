class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :category_id
      t.string :title, null: false
      t.text :body_top, null: false
      t.text :body_middle, null: false
      t.text :body_bottom, null: false
      t.boolean :is_release, null: false, default:true
      t.timestamps
    end
  end
end
