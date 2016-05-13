class StopData
  # we need two data structures:
  # list of "Edges", each corresponding to a stop, all in one array
  # a big set of which edges are adjacent to one another.
  # each element in the adjacency list should be a reference to the one in the "Edges" array

  def self.adjacency_list
    vertices = Stop.all.to_a.map {|stop| Vertex.new(stop)}
    list = AdjacencyList.new(vertices)

    stop_id_adjacency_list.each do |pair|
      list.vertex(pair.first).add(list.vertex(pair.second))
    end

    list
  end

  def self.regenerate_stop_id_adjacency_list
    set = Set.new
    Trip.all.each do |trip|
      array = trip.ordered_stops
      result = []
      array.each_index do |i|
        next if ( i - 1 ) < 0
        result.push([array[i - 1].stop_id, array[i].stop_id])
      end
      set.merge(result)
    end
    set
  end

  # Unless a new stop is added, these are correctly generated from the GTFS data.
  def self.stop_id_adjacency_list
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

end
