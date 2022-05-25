# frozen_string_literal: true

class AddParentToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :parent_id, :integer, null: true
  end
end
