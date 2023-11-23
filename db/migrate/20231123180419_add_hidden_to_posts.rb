class AddHiddenToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :hidden, :boolean, null: false, default: false
  end
end
