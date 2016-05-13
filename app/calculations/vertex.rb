class Vertex
  attr_accessor :source, :neighbors, :status, :ancestor

  def initialize(source, *neighbors)
    @source = source
    @neighbors = Array(neighbors)
    @status = "undiscovered"
  end

  def add(*neighbors)
    @neighbors.push(neighbors).flatten!.uniq!
  end

  def remove(*neighbors)
    @neighbors = @neighbors - Array(neighbors).flatten
  end

  ["undiscovered", "discovered", "explored"].each do |status|
    define_method "#{status}?" do
      @status == status
    end

    define_method "#{status}!" do
      @status = status
    end
  end
end
