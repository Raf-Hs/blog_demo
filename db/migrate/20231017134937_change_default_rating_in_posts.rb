class ChangeDefaultRatingInPosts < ActiveRecord::Migration[7.1]
  def change
    change_column :posts, :rating, :float, default: 0.0
  end
end
