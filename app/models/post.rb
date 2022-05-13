class Post < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :user
  has_many_attached :files
  has_many :comments, dependent: :destroy
  validates :files, file_size: { less_than: 2.gigabytes }
  #validate :correct_file_type
  enum status: { unpublished: 0, published: 1 }

 # def correct_file_type
  #  if file.attached? && !file.content_type.in?(%i(png jpg jpeg))
   #   errors.add(:file, 'Must be a PNG or a JPEG/JPG file')
   # end
  #end

end
