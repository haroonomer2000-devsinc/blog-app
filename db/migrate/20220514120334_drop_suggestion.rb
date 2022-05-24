# frozen_string_literal: true

class DropSuggestion < ActiveRecord::Migration[5.2]
  def change
    drop_table :suggestions
  end
end
