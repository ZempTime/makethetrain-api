class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.string :block_id
      t.string :route_id
      t.string :direction_id
      t.string :trip_headsign
      t.string :shape_id
      t.string :service_id
      t.string :trip_id

      t.timestamps
    end
  end
end
