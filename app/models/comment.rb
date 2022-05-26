# frozen_string_literal: true

class Comment < ApplicationRecord
  scope :active, -> { where(status: [nil, "reported"]) }   
    
  belongs_to :post
  belongs_to :user
  belongs_to :parent, class_name: 'Comment', optional: true

  has_many_attached :files
  has_many :comments, dependent: :destroy, foreign_key: :parent_id
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true
  validates :files, file_size: { less_than_or_equal_to: 4.megabytes, message: "Please Check File Size" },
  file_content_type: { allow: ['image/jpeg', 'image/jpg', 'image/png'],
  message: "Please Check File Format"}
end
