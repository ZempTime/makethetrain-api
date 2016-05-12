class UserTrip < ApplicationRecord
  belongs_to :from, class_name: "Stop", foreign_key: :to_id,   primary_key: :stop_id
  belongs_to :to,   class_name: "Stop", foreign_key: :from_id, primary_key: :stop_id

  validates_numericality_of :delay
  validates_presence_of :from, :to, :delay, :departure_at

  def calculate_segments
    bfs = BreadthFirstSearch.new(from, to)
    segments = []

    bfs.segments.each_with_index do |segment, index|
      segment = Segment.new(
        from:           segment[:from],
        to:             segment[:to],
        direction:      segment[:direction],
        segment_number: index
      )
      segments.push segment
    end

    @segments = segments
  end

  def segments
    @segments
  end
end
