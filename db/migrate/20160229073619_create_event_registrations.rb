class CreateEventRegistrations < ActiveRecord::Migration
  def change
    create_table :event_registrations do |t|
      t.integer :event_id
      t.integer :user_id
      t.string :status

      t.timestamps null: false
    end
  end
end
