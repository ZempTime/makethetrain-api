class DepthFirstSearch
  attr_accessor :graph, :edges

  def initialize(graph, edges)
    @graph = Array.new(graph)
    @edges = Array.new(edges)
  end

  def search
    @time = 0
    @graph.each do |v|
      visit(graph, v) if v.color == "WHITE"
    end
    @graph
  end

  def visit(graph, u)
    @time += 1
    u.d = @time
    u.color = "GRAY"
    adjacent_vertices = @edges.select { |e| e.include?(u)}
    adjacent_vertices.each do |v|
      if v.color == "WHITE"
        v.p << u
        visit(graph, v)
      end
    end
    u.color == "BLACK"
    @time += 1
    u.f = @time
  end
end
