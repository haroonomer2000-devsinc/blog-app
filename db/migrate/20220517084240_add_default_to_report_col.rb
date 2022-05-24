# frozen_string_literal: true

class AddDefaultToReportCol < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :reported, :status
    change_column :comments, :status, :string, default: nil
  end
end
