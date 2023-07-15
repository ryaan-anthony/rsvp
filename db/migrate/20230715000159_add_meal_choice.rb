class AddMealChoice < ActiveRecord::Migration[7.0]
  def change
    add_column :guests, :meal_choice, :integer
  end
end
