class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  enum status: { unpublished: 0, published: 1 }
end
