# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :user

  validates :user_id, uniqueness: { scope: %i[likeable_id likeable_type] }
end
