class Graph
  def initialize(edges=nil, adjacency_list=nil)
    if !(edges && adjacency_list)
      data = StopData.graph_data(StopData.edges, StopData.stop_id_adjacency_list)
    end

    @edges = edges || data[:edges]
    @adjacency_list = adjacency_list || data[:adjacency_list]
  end

  def edges
    @edges
  end

  def adjacency_list
    @adjacency_list
  end

  def adjacent_edges(edge)
    results = []
    adjacency_list.each do |pair|
      if pair.include?(edge)
        adjacent_edge = (pair - [edge]).first
        results.push(adjacent_edge)
      end
    end
    results
  end

  def edge_for_item(item)
    edges.select { |v| v.item == item }.first
  end
end
