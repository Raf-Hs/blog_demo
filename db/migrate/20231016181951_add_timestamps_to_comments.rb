class AddTimestampsToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :created_at, :datetime
    add_column :comments, :updated_at, :datetime
  end
end
