# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  belongs_to :parent, class_name: 'Comment', optional: true

  has_many_attached :files
  has_many :comments, foreign_key: :parent_id
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true
end
