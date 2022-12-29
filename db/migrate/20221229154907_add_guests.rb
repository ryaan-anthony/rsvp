class AddGuests < ActiveRecord::Migration[7.0]
  def change
    create_table :guests do |t|
      t.string :first_name
      t.string :last_name
      t.string :group
      t.boolean :status
      t.integer :parent_id
      t.timestamps
    end
  end
end
