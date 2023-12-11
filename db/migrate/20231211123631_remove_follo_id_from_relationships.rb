class RemoveFolloIdFromRelationships < ActiveRecord::Migration[6.1]
  def change
    remove_column :relationships, :follo_id, :integer
  end
end
