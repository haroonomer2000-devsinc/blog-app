# frozen_string_literal: true

class AddIndexLikes < ActiveRecord::Migration[5.2]
  def change
    add_index :likes, %i[user_id likeable_id likeable_type], unique: true
  end
end
