class AddSecondsSinceMidnightToStopTimes < ActiveRecord::Migration[5.0]
  def change
    add_column :stop_times, :seconds_since_midnight, :integer
  end
end
