class Bfs
  attr_accessor :list, :from, :to, :result

  def initialize(list, from, to)
    @list = list
    @from = from
    @to = to
  end

  def run
    starting_stop = @list.vertex(@from)
    starting_stop.discovered!
    starting_stop.ancestor = nil

    @queue = []
    @queue.push starting_stop

    while @queue.any? do
      current_vertex = @queue.shift
      current_vertex.neighbors.each do |neighboring_vertex|
        if neighboring_vertex.undiscovered?
          neighboring_vertex.discovered!
          neighboring_vertex.ancestor = current_vertex
          @queue.push(neighboring_vertex)
        end
        current_vertex.explored!
      end
    end
    set_result
  end

  def set_result
    path = []
    destination = @list.vertex(@to)

    path.push(destination)

    while path.last.ancestor != nil
      path << path.last.ancestor
    end

    @result = path.map { |v| v.source}.reverse
  end
end
