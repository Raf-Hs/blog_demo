class RemoveUnwantedColumnsFromComments < ActiveRecord::Migration[6.0] # Replace with your Rails version
  def change
    remove_column :comments, :user_id
    remove_column :comments, :created_at
    remove_column :comments, :updated_at
  end
end
