class AddWelcomeParty < ActiveRecord::Migration[7.0]
  def change
    add_column :guests, :welcome_party, :boolean
  end
end
