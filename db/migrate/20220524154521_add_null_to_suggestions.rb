# frozen_string_literal: true

class AddNullToSuggestions < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:suggestions, :to_replace, false)
    change_column_null(:suggestions, :replacement, false)
  end
end
