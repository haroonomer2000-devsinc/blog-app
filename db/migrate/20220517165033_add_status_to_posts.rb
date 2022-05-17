class AddStatusToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :report_status, :string, default: nil
  end
end
