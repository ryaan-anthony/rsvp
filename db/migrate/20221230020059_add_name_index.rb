class AddNameIndex < ActiveRecord::Migration[7.0]
  def change
    add_index :guests, [:first_name, :last_name], unique: true
  end
end
