# frozen_string_literal: true

class AddIndexToComments < ActiveRecord::Migration[5.2]
  def change
    add_index :comments, :parent_id
  end
end
