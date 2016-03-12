class Calendar < ApplicationRecord
  validates_presence_of :service_id, :start_date, :end_date
  has_many :trips, primary_key: :service_id, foreign_key: :service_id
end
