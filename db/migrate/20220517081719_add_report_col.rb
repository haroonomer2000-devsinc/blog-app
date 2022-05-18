class AddReportCol < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :reported, :boolean
  end
end
