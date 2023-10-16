class Comment < ApplicationRecord
  belongs_to :post
  has_rich_text :body
  belongs_to :post
  validates :email, presence: true
  validates :comment, presence: true
end
