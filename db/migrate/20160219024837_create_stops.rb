class CreateStops < ActiveRecord::Migration[5.0]
  def change
    create_table :stops do |t|
      t.float :stop_lat
      t.float :stop_lon
      t.string :stop_id
      t.string :stop_description
      t.string :stop_name
      t.string :location_type
      t.string :stop_code
      t.string :stop_desc

      t.timestamps
    end
  end
end
