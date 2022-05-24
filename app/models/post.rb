# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :suggestions, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many_attached :files
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true

  enum status: { UNPUBLISHED: 0, PUBLISHED: 1 }

  def apply_suggestion(suggestion)
    description.gsub!(/#{suggestion.to_replace}/i, suggestion.replacement)
    save!
  end
end
