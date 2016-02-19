class CreateStopTimes < ActiveRecord::Migration[5.0]
  def change
    create_table :stop_times do |t|
      t.string :trip_id
      t.string :arrival_time
      t.string :departure_time
      t.string :stop_id
      t.string :stop_sequence

      t.timestamps
    end
  end
end
