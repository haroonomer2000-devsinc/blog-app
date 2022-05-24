# frozen_string_literal: true

class AddLockableToDevise < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.column :failed_attempts, :integer, default: 0, null: false
      t.column :locked_at, :datetime
      t.column :unlock_token, :string
      t.index :unlock_token, unique: true
    end
  end
end
