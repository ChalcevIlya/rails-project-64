class AddUniqueIndexToPostLikesUserIdAndPostId < ActiveRecord::Migration[7.2]
  def change
    add_index :post_likes, [:user_id, :post_id], unique: true
  end
end
