# frozen_string_literal: true

class DropLike < ActiveRecord::Migration[5.2]
  def change
    drop_table :likes
  end
end
