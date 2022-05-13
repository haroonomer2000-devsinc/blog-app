class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many_attached :files
  validates :body, presence: :true
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: :parent_id
end
