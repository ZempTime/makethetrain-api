class Path
  attr_accessor :stops, :edges, :graph
  # based on: https://en.wikipedia.org/wiki/List_of_MetroLink_(St._Louis)_stations#/media/File:MetroLink_map_Oct2008.svg

  # trips contain a number of stops at specific times
  # given start/stop, need to determine the # of trips to find, and what stops
  # determine shortest distance, # of stops, need to consider transfers at different times?
  #   -> make query for forthcoming stops based on

  EAST = "0"
  WEST = "1"

  def self.depth_first_search
    path = self.new
    dfs = DepthFirstSearch.new(path.graph, path.edges)
    graph = dfs.search
  end

  def initialize
    @stops = Stop.all.to_a
    @edges = set_edges
    @graph = @stops.map {|stop| Vertice.new(stop)}
  end

  def edge_to_stations(edge)
    [@stops[edge[0]], @stops[edge[1]]]
  end

  def set_edges
    result = []
    result += array_to_edges(stop_names_to_ids(blue_line_names))
    result += array_to_edges(stop_names_to_ids(red_line_names))
    result
  end

  def array_to_edges(array)
    result = []
    array.each_index do |i|
      next if i == 0
      result.push([array[i - 1], array[i]])
    end
    result
  end

  def blue_line_names
    [
      "SHREWSBURY", "SUNNEN", "MAPLEWOOD", "BRENTWOOD", "RICHMOND HEIGHTS", "CLAYTON", "FORSYTH", "U CITY BIG BEND", "SKINKER",
      "FOREST PARK", "CENTRAL WEST END", "GRAND", "UNION STA", "CIVIC CENTER", "STADIUM", "8TH AND PINE", "CONVENTION CENTER", "LACLEDES LANDING", "EAST RIVERFRONT", "5TH & MISSOURI", "EMERSON PARK", "JJK CENTER", "WASHINGTON PARK", "FAIRVIEW HEIGHTS"
    ]
  end

  def stop_names_to_ids(array)
    array.map do |name|
      stop = Stop.where(stop_name: "#{name} METROLINK STATION").first
      @stops.index(stop)
    end
  end

  def red_line_names
    [
      "LAMBERT MAIN TRML", "LAMBERT EAST TRML", "NORTH HANLEY", "UMSL NORTH", "UMSL SOUTH", "ROCK ROAD", "WELLSTON", "DELMAR",
      "FOREST PARK", "CENTRAL WEST END", "GRAND", "UNION STA", "CIVIC CENTER", "STADIUM", "8TH AND PINE", "CONVENTION CENTER", "LACLEDES LANDING", "EAST RIVERFRONT", "5TH & MISSOURI", "EMERSON PARK", "JJK CENTER", "WASHINGTON PARK", "FAIRVIEW HEIGHTS",
      "MEMORIAL HOSPITAL", "SWANSEA", "BELLEVILLE", "COLLEGE", "SHILOH-SCOTT"
    ]
  end

  def red_line
    red_line_names.map { |s| Stop.where(stop_name: "#{s} METROLINK STATION").first.id}
  end


  class Vertice
    attr_accessor :p, :color, :d, :f, :stop

    # v.d = when vertex discovered
    # v.f = when all adjancent vertexes explored
    # v.p = predecessor
    # v.color = WHITE (nonexplored), GREY (some explored, some not), BLACK (explored)

    def initialize(stop)
      @stop = stop
      @color = "WHITE"
      @p = []
    end

    def predecessors
      @p
    end
  end
end
