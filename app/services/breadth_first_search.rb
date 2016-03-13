class BreadthFirstSearch
  attr_accessor :vertices, :stops, :edges, :from, :to, :path, :segments, :results

  def initialize(from, to)
    @graph = StopGraph.new
    @stops = @graph.stops
    @vertices = @graph.vertices
    @edges = @graph.edges

    @from = from
    @to = to

    @s = @graph.find_vertex(from)
    search
    calculate_path
    calculate_segments
    determine_directions
  end

  def search
    @s.color = "GRAY"
    @s.distance = 0
    @s.ancestor = nil

    @queue = []
    @queue.push @s

    while @queue.any? do
      u = @queue.shift
      @graph.adjacent_vertices(u).each do |v|
        if v.color == "WHITE"
          v.color = "GRAY"
          v.distance = u.distance + 1
          v.ancestor = u
          @queue.push(v)
        end
        u.color = "BLACK"
      end
    end
  end

  def calculate_path
    dest = @graph.find_vertex(@to)
    path = []

    path << dest
    while path.last.ancestor != nil
      path << path.last.ancestor
    end
    @path = path.map {|p| p.stop }.reverse
  end

  def calculate_segments
    @segments = []
    lines = @path.map &:route_colors
    if lines.first.count == 1 && (lines.last != lines.first)
      transfer_index = lines.each_index.select { |i| lines[i].count == 2}.max # Grab last index with count of 2
      @segments.push({from: @path.first, to: @path.at(transfer_index)}, {from: @path.at(transfer_index), to: @path.last})
    else
      @segments.push({from: @path.first, to: @path.last})
    end
  end

  def determine_directions
    @segments.each do |segment|
      color = (segment[:from].route_colors & segment[:to].route_colors).first.downcase
      segment[:direction] = @graph.direction(color, segment[:from], segment[:to])
    end
  end
end
