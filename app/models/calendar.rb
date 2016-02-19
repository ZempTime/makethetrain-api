class Calendar < ApplicationRecord
  validates_presence_of :service_id, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :start_date, :end_date
  has_many :trips, primary_key: :service_id, foreign_key: :service_id
end
