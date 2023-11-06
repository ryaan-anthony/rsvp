class AddTablesToGuests < ActiveRecord::Migration[7.0]
  def change
    add_column :guests, :table, :integer
  end
end
