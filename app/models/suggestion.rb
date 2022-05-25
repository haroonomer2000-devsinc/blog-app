# frozen_string_literal: true

class Suggestion < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :to_replace, presence: true
  validates :replacement, presence: true
end
