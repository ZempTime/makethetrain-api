require 'test_helper'

class VertexTest < ActiveSupport::TestCase

  test "can add neighbors to a vertex" do
    v = Vertex.new(Stop.first)
    assert_equal 0, v.neighbors.count
    v.add(Stop.second)
    assert_equal 1, v.neighbors.count
  end

  test "two identical neighbors will only count as one" do
    v = Vertex.new(Stop.first)
    v.add(Stop.second)
    v.add(Stop.second)
    assert_equal 1, v.neighbors.count
  end

  test "can remove neighbors from a vertex" do
    v = Vertex.new(Stop.first)
    v.add(Stop.second)
    assert_equal 1, v.neighbors.count
    v.remove(Stop.second)
    assert_equal 0, v.neighbors.count
  end
end
