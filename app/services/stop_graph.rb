require 'set'

class StopGraph
  attr_accessor :vertices, :edges, :stops

  def initialize
    @stops = Stop.all.order(stop_id: :asc)
    @edges = Set.new set_data
    # calculate_edges(Trip.all)
    @vertices = @stops.map {|stop| Vertex.new(stop)}
    edge_ids_to_indexes!
  end

  def adjacent_vertices(v)
    i = find_vertex_index(v)
    edges_with_v = @edges.select { |e| e.include?(i)}
    adjacent_vertice_indexes = edges_with_v.map {|edge| edge.select { |e| e != i}}.flatten.uniq
    adjacent_vertice_indexes.map { |vi| @vertices.at(vi)}
  end

  def find_vertex_index(obj)
    if obj.is_a? String
      @vertices.find_index { |v| v.stop.stop_id == obj }
    elsif obj.is_a? Stop
      @vertices.find_index { |v| v.stop.stop_id == obj.stop_id }
    elsif obj.is_a? Vertex
      @vertices.index(obj)
    end
  end

  def find_vertex(obj)
    if obj.is_a? Stop
      @vertices[find_vertex_index(obj.stop_id)]
    end
  end

  class Vertex
    attr_accessor :color, :ancestor, :distance, :stop

    def initialize(stop)
      @stop = stop
      @color = "WHITE"
    end
  end

  def edge_ids_to_indexes!
    @edges.collect! { |edge| [find_vertex_index(edge[0]), find_vertex_index(edge[1])] }
  end

  def calculate_edges(trips)
    trips.each do |trip|
      array = trip.ordered_stops
      result = []
      array.each_index do |i|
        next if ( i - 1 ) < 0
        result.push([array[i - 1].stop_id, array[i].stop_id])
      end
      @edges.merge(result)
    end
  end

  def set_data
    [
      ["10601", "10602"], ["10602", "10603"], ["10603", "10604"], ["10604", "10605"],
      ["10605", "11103"], ["11103", "14274"], ["14753", "14754"], ["14754", "14755"],
      ["14755", "14756"], ["14756", "14757"], ["14757", "14758"], ["14758", "14759"],
      ["14759", "14760"], ["14760", "14761"], ["14761", "10626"], ["10626", "10625"],
      ["10625", "10624"], ["10624", "10623"], ["10623", "10622"], ["10622", "13662"],
      ["13662", "10620"], ["10620", "10619"], ["10619", "10618"], ["10618", "10617"],
      ["10617", "10616"], ["10616", "10599"], ["10599", "10600"], ["10600", "10601"],
      ["10602", "10601"], ["10601", "10600"], ["10600", "10599"], ["10599", "10616"],
      ["10616", "10617"], ["10617", "10618"], ["10618", "10619"], ["10619", "10620"],
      ["10620", "13662"], ["13662", "10622"], ["10622", "10623"], ["10623", "10624"],
      ["10624", "10625"], ["10625", "10626"], ["10626", "14761"], ["14761", "14760"],
      ["14760", "14759"], ["14759", "14758"], ["14758", "14757"], ["14757", "14756"],
      ["14756", "14755"], ["14755", "14754"], ["14754", "14753"], ["14274", "11103"],
      ["11103", "10605"], ["10605", "10604"], ["10604", "10603"], ["10603", "10602"],
      ["10626", "10627"], ["10627", "10628"], ["10628", "10629"], ["10629", "10630"],
      ["10630", "10631"], ["10631", "10632"], ["10632", "10633"], ["10633", "10634"],
      ["10634", "10633"], ["10633", "10632"], ["10632", "10631"], ["10631", "10630"],
      ["10630", "10629"], ["10629", "10628"], ["10628", "10627"], ["10627", "10626"]
    ]
  end

  def direction(color, from, to)
    line = self.send(color)
    if line.index(from.stop_id) < line.index(to.stop_id)
      return "1" # west
    else
      return "0"
    end
  end

  def mlr
    # west to east
    [
      "10634", "10633", "10632", "10631", "10630", "10629", "10628", "10627",
      "10626", "10625", "10624", "10623", "10622", "13662", "10620", "10619",
      "10618", "10617", "10616", "10599", "10600", "10601", "10602", "10603",
      "10604", "10605", "11103", "14274"
    ]
  end

  def mlb
    # west to east
    [
      "14753", "14754", "14755", "14756", "14757", "14758", "14759", "14760",
      "14761", "10626", "10625", "10624", "10623", "10622", "13662", "10620",
      "10619", "10618", "10617", "10616", "10599", "10600", "10601", "10602"
    ]
  end
end
