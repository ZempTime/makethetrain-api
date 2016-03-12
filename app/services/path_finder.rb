class PathFinder
  attr_accessor :path, :segments

  EAST = "0"
  WEST = "1"

  def initialize(from, to)
    @from ||= Stop.find(6)  #=> default Shrewsbury
    @to   ||= Stop.find(35) #=> default North Hanley

    @sg = StopGraph.new
    @bfs = BreadthFirstSearch.new(@sg, @from, @to)
    @path = @bfs.path
    @segments = calculate_segments
  end

  def calculate_segments
    line_statuses = @path.map{ |s| [blue_line.include?(s.stop_id), red_line.include?(s.stop_id)]}
    pattern = line_statuses.first
    changes_at = []
    line_statuses.each_with_index do |s, i|
      if s != pattern && s != []
        changes_at << i
        pattern = s
      end
    end
    changes_at
  end

  def blue_line
    ["14753", "14754", "14755", "14756", "14757", "14758", "14759", "14760", "14761", "10626", "10625", "10624", "10623", "10622", "13662", "10620", "10619", "10618", "10617", "10616", "10599", "10600", "10601", "10602"]
  end

  def red_line
    ["10634", "10633", "10632", "10631", "10630", "10629", "10628", "10627", "10626", "10625", "10624", "10623", "10622", "13662", "10620", "10619", "10618", "10617", "10616", "10599", "10600", "10601", "10602", "10603", "10604", "10605", "11103", "14274"]
  end
end
