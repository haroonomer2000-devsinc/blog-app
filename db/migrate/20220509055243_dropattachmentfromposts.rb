# frozen_string_literal: true

class Dropattachmentfromposts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :attachment
  end
end
