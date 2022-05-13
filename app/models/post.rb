class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: :true
  validates :description, presence: :true
  has_many_attached :files
  has_many :comments, dependent: :destroy
  enum status: { unpublished: 0, published: 1 }
end
