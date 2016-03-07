class PathFinder
  attr_accessor :path

  def initialize(from, to)
    @from ||= Stop.find(6)  #=> Shrewsbury
    @to   ||= Stop.find(35) #=> North Hanley

    @sg = StopGraph.new
    @bfs = BreadthFirstSearch.new(@sg, @from, @to)
    @path = @bfs.path
  end

  EAST = "0"
  WEST = "1"

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
