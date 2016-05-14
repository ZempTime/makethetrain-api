class UserTrip < ApplicationRecord
  belongs_to :from, class_name: "Stop", foreign_key: :to_id,   primary_key: :stop_id
  belongs_to :to,   class_name: "Stop", foreign_key: :from_id, primary_key: :stop_id

  validates_numericality_of :delay
  validates_presence_of :from, :to, :delay, :departure_at

  def segments
    @segments ||= calculate_segments
  end

  def calculate_segments
    @segmenter = Segmenter.new(from, to, delay)
    @segmenter.run
    @segments = @segmenter.segments
  end
end
