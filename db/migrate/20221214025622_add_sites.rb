# frozen_string_literal: true

class AddSites < ActiveRecord::Migration[7.0]
  def change
    create_table :sites do |t|
      t.string :site_id
      t.string :template

      t.timestamps
    end
  end
end
