class StopGraph
  attr_accessor :graph, :edges, :stops
  # undirected, unweighted
  # ...for now

  def initialize
    @stops = Stop.all.order(stop_id: :asc).to_a
    @edges = calculate_edges
    @graph = @stops.map {|stop| Vertex.new(stop)}
  end

  class Vertex
    attr_accessor :color, :ancestor, :distance, :stop

    def initialize(stop)
      @stop = stop
      @color = "WHITE"
    end
  end

  def calculate_edges
    result = []
    result += array_to_edges(stop_names_to_ids(blue_line_names))
    result += array_to_edges(stop_names_to_ids(red_line_names))
    result
  end

  def array_to_edges(array)
    result = []
    array.each_index do |i|
      next if ( i - 1 ) < 0
      result.push([array[i - 1], array[i]])
    end
    result
  end

  def stop_names_to_ids(array)
    array.map do |name|
      stop = Stop.where(stop_name: "#{name} METROLINK STATION").first
      @stops.index(stop)
    end
  end

  def blue_line_names
    [
      "SHREWSBURY", "SUNNEN", "MAPLEWOOD", "BRENTWOOD", "RICHMOND HEIGHTS", "CLAYTON", "FORSYTH", "U CITY BIG BEND", "SKINKER",
      "FOREST PARK", "CENTRAL WEST END", "GRAND", "UNION STA", "CIVIC CENTER", "STADIUM", "8TH AND PINE", "CONVENTION CENTER", "LACLEDES LANDING", "EAST RIVERFRONT", "5TH & MISSOURI", "EMERSON PARK", "JJK CENTER", "WASHINGTON PARK", "FAIRVIEW HEIGHTS"
    ]
  end

  def red_line_names
    [
      "LAMBERT MAIN TRML", "LAMBERT EAST TRML", "NORTH HANLEY", "UMSL NORTH", "UMSL SOUTH", "ROCK ROAD", "WELLSTON", "DELMAR",
      "FOREST PARK", "CENTRAL WEST END", "GRAND", "UNION STA", "CIVIC CENTER", "STADIUM", "8TH AND PINE", "CONVENTION CENTER", "LACLEDES LANDING", "EAST RIVERFRONT", "5TH & MISSOURI", "EMERSON PARK", "JJK CENTER", "WASHINGTON PARK", "FAIRVIEW HEIGHTS",
      "MEMORIAL HOSPITAL", "SWANSEA", "BELLEVILLE", "COLLEGE", "SHILOH-SCOTT"
    ]
  end
end
