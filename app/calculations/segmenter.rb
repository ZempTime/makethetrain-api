class Segmenter
  attr_accessor :path, :segments, :from, :to

  def initialize(from, to)
    @from = from
    @to   = to
    @segments = []

    @bfs = Bfs.new(StopData.adjacency_list, @from, @to)
  end

  def run
    @bfs.run
    @path = @bfs.result
    @segments = calculate_segments
  end

  def calculate_segments
    stops = []
    stops.push(path.first)

    if path.first.both_lines?
      stops.push(path.last)
      create_segments(stops)
    elsif path.first.red_line? && path.last.red_line?
      stops.push(path.last)
      create_segments(stops)
    elsif path.first.blue_line? && path.last.blue_line?
      stops.push(path.last)
      create_segments(stops)
    elsif path.first.red_line? && path.last.blue_line?
      transfer_stop = path.select { |p| p.both_lines? }.first
      stops.push(transfer_stop)
      stops.push(path.last)
      create_segments(stops)
    elsif path.first.blue_line? && path.last.red_line?
      transfer_stop = path.select { |p| p.both_lines? }.first
      stops.push(transfer_stop)
      stops.push(path.last)
      create_segments(stops)
    else
      raise DidntThinkAboutThisError
    end
  end

  def create_segments(stops)
    boarding_stop = stops.first
    stop_number = 0
    while boarding_stop != stops.last
      exiting_stop = stops.at(stops.find_index(boarding_stop) + 1)

      segments.push Segment.new( boarding_stop, exiting_stop, stop_number)

      stop_number += 1
      boarding_stop = exiting_stop
    end

    segments
  end

  def path_route_colors
    @path_route_colors ||= path.pluck(:route_colors)
  end

  def prc
    path_route_colors
  end

  def blue_line
    ["14753", "14754", "14755", "14756", "14757", "14758", "14759", "14760", "14761", "10626", "10625", "10624", "10623", "10622", "13662", "10620", "10619", "10618", "10617", "10616", "10599", "10600", "10601", "10602"]
  end

  def red_line
    ["10634", "10633", "10632", "10631", "10630", "10629", "10628", "10627", "10626", "10625", "10624", "10623", "10622", "13662", "10620", "10619", "10618", "10617", "10616", "10599", "10600", "10601", "10602", "10603", "10604", "10605", "11103", "14274"]
  end
end
