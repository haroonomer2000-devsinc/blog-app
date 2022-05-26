# frozen_string_literal: true

class AddFkComments < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :comments, :users
  end
end
