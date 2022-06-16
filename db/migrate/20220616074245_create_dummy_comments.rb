class CreateDummyComments < ActiveRecord::Migration[5.2]
  def change
    create_table :dummy_comments do |t|
      t.text :body
      t.integer :post_id
      t.integer :user_id
      t.integer :parent_id
      t.string :status

      t.timestamps
    end
  end
end
