class AdjacencyList
  attr_accessor :list

  def initialize(list)
    @list = list
  end

  def vertices
    list
  end

  def vertex(item)
    if item.is_a? Stop
      list.select { |v| v.source == item }.first
    elsif item.is_a? String
      list.select { |v| v.source.stop_id == item }.first
    end
  end
end
