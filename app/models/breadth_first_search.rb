class BreadthFirstSearch
  attr_accessor :graph, :edges, :s

  def initialize(stops, edges, source_stop_index)
    @stops = Array.new(stops)
    @graph = @stops.map {|stop| Vertex.new(stop)}
    @edges = Array.new(edges)
    @s = @graph[source_stop_index]
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

  def stops_until(destination_stop)
    index = @stops.index(destination_stop)
    dest = @graph.at(index)
    path = []

    path << dest
    while path.last.ancestor != nil
      path << path.last.ancestor
    end
    path.map {|p| p.stop.stop_name }
  end

  class Vertex
    attr_accessor :color, :ancestor, :distance, :stop

    def initialize(stop)
      @stop = stop
      @color = "WHITE"
    end
  end
end
