# frozen_string_literal: true

class PostComment < ApplicationRecord
  has_ancestry

  belongs_to :post
  belongs_to :user

  validates :body, presence: true
end
