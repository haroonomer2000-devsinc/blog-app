class Post < ApplicationRecord
  belongs_to :user
  has_many :suggestions, dependent: :destroy
  has_many :likes, as: :likeable
  has_many_attached :files
  has_many :comments, dependent: :destroy

  validates :title, presence: :true
  validates :description, presence: :true

  enum status: { unpublished: 0, published: 1 }

  def apply_suggestion(suggestion)
    self.description.gsub!(/#{suggestion.to_replace}/i, suggestion.replacement)
    self.save!
  end
end
