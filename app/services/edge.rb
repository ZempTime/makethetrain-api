class Edge
  attr_accessor :ancestor, :item

  def initialize(item)
    @item = item
  end

  define_method :color do
    @color ||= "white"
  end

  ["white", "gray", "black"].each do |color|
    define_method "#{color}?" do
      @color == color
    end

    define_method "#{color}!" do
      @color = color
    end
  end
end
