class AddIndexToProducts < ActiveRecord::Migration[6.0]
  def change
    change_column :products, :title, :string, unique: true
    add_index :products, :title, unique: true
  end
end
