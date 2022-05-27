# frozen_string_literal: true

class Post < ApplicationRecord
  scope :active, -> { where(report_status: [nil, 'reported']) }

  belongs_to :user
  has_many :suggestions, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many_attached :files
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 30 }
  validates :files, file_size: { less_than_or_equal_to: 4.megabytes, message: I18n.t(:invalid_file_size) },
                    file_content_type: { allow: ['image/jpeg', 'image/jpg', 'image/png'],
                                         message: I18n.t(:invalid_file_format) }

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
