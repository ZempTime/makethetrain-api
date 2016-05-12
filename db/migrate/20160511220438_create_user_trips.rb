class CreateUserTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :user_trips do |t|
      t.string :from_id
      t.string :to_id
      t.integer :user_uid
      t.datetime :departure_at
      t.integer :delay, default: 0
      t.integer :segment_number, default: 0

      t.timestamps
    end
  end
end
