# frozen_string_literal: true

class AddPublishdateToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :published_at, :datetime, default: nil
  end
end
