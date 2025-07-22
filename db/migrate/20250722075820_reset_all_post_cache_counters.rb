class ResetAllPostCacheCounters < ActiveRecord::Migration[7.2]
  
  def up
    Post.all.each do |post|
      Post.update_counters(post.id, likes_count: post.likes.count)
    end
  end

  def down; end
end
