class AddTablePosition < ActiveRecord::Migration[7.0]
  def change
    add_column :guests, :table_pos, :integer, default: 0
  end
end
