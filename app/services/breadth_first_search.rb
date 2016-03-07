class BreadthFirstSearch
  attr_accessor :graph, :stops, :edges, :from, :to, :path

  def initialize(stop_graph, from, to)
    @stops = Array.new(stop_graph.stops)
    @graph = Array.new(stop_graph.graph)
    @edges = Array.new(stop_graph.edges)
    @from = from
    @to = to

    @s = @graph[@stops.index(@from)]
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
      adjacent_vertices(@graph.index(u)).each do |v|
        v = @graph.at(v)
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

  def adjacent_vertices(vertex_index)
    v = vertex_index
    Array.new(@edges).select { |e| e.include?(v)}.map {|edge| edge.select { |e| e != v}}.flatten.uniq
  end

  def calculate_path
    index = @stops.index(@to)
    dest = @graph.at(index)
    path = []

    path << dest
    while path.last.ancestor != nil
      path << path.last.ancestor
    end
    path.map {|p| p.stop }.reverse
  end
end
