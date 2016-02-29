class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :web_address

      t.timestamps null: false
    end
  end
end
