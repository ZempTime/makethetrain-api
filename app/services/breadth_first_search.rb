class BreadthFirstSearch
  attr_accessor :vertices, :stops, :edges, :from, :to, :path

  def initialize(from, to)
    @graph = StopGraph.new
    @stops = @graph.stops
    @vertices = @graph.vertices
    @edges = @graph.edges

    @from = from
    @to = to

    @s = @graph.find_vertex(from)
    search
    @path = calculate_path
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
    path.map {|p| p.stop }.reverse
  end
end
