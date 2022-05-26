# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :suggestions, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many_attached :files
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 30 }
  validates :files, file_size: { less_than_or_equal_to: 4.megabytes, message: "Please Check File Size" },
  file_content_type: { allow: ['image/jpeg', 'image/jpg', 'image/png'],
  message: "Please Check File Format"}

  enum status: { UNPUBLISHED: 0, PUBLISHED: 1 }

  def apply_suggestion(suggestion)
    description.gsub!(/#{suggestion.to_replace}/i, suggestion.replacement)
    save!
  end

  def publish_post
    self.PUBLISHED!
    self.published_at = Time.zone.now
  end
end
