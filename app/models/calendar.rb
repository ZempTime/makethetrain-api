class Calendar < ApplicationRecord
  validates_presence_of :service_id, :start_date, :end_date
  has_many :trips, primary_key: :service_id, foreign_key: :service_id

  scope :active_today, -> { where("start_date < ?", DateTime.now)
                            .where("end_date > ?", DateTime.now)
                            .where("#{weekday}" => true).first }

  def self.weekday
    if DateTime.now.hour < 3
      DateTime.yesterday.strftime("%A").downcase
    else
      DateTime.now.strftime("%A").downcase
    end
  end
end
