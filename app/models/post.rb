class Post < ApplicationRecord
  belongs_to :user
  has_many :suggestions, dependent: :destroy
  validates :title, presence: :true
  validates :description, presence: :true
  has_many_attached :files
  has_many :comments, dependent: :destroy
  enum status: { unpublished: 0, published: 1 }

  def apply_suggestion(suggestion)
    desc_arr = self.description.split(" ")
    desc_arr.grep(/#{suggestion.to_replace}/i).each do |word|
      self.description.gsub! word, suggestion.replacement
    end
    self.save!
  end
end
