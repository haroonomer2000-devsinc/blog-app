class CreateDummyPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :dummy_posts do |t|
      t.string :title
      t.string :description
      t.integer :user_id
      t.integer :status

      t.timestamps
    end
  end
end
