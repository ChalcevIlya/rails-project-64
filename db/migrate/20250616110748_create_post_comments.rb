# frozen_string_literal: true

class CreatePostComments < ActiveRecord::Migration[7.2]
  def change
    create_table :post_comments do |t|
      t.text :body, null: false
      t.string :ancestry
      t.references :post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :post_comments, :ancestry
  end
end
