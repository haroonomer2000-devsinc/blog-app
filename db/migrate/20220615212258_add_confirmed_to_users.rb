class AddConfirmedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :dummy_users, :confirmed_at, :datetime, null: false
  end
end
