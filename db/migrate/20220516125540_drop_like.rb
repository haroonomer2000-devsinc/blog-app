# frozen_string_literal: true

class DropLike < ActiveRecord::Migration[5.2]
  def change; end
  drop_table :likes
end
