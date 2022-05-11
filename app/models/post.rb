class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  has_many :comments, dependent: :destroy
  enum status: { unpublished: 0, published: 1 }
end
