class RenameColumnBodyToContentInTablePostComments < ActiveRecord::Migration[7.2]
  def change
    rename_column :post_comments, :body, :content
  end
end
