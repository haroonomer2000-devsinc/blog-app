# frozen_string_literal: true

class RemoveComments < ActiveRecord::Migration[5.2]
  def change; end
  drop_table :comments
end
