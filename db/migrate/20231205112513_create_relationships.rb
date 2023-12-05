class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follow_id
      t.integer :follo_id
      t.timestamps
    end
  end
end
