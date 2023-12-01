require 'pry'
# lines = File.readlines('sample.txt')
# lines = File.readlines('sample_two.txt')
# lines = File.readlines('sample_three.txt')
lines = File.readlines('input.txt')

class GraphNode
  attr_accessor :value, :neighbors

  def initialize(value)
    @value = value
    @neighbors = []
  end

  def small_cave?
    @value.downcase == @value
  end

  def terminator?
    @value == 'start' || @value == 'end'
  end
end

class Graph
  attr_accessor :nodes

  def initialize
    @nodes = {}
  end

  def add_edge(a,b)
    node_a = @nodes[a] || @nodes[a] = GraphNode.new(a)
    node_b = @nodes[b] || @nodes[b] = GraphNode.new(b)

    node_a.neighbors << node_b
    node_b.neighbors << node_a
  end

  def print_edges
    @nodes.each do |key, node|
      puts "#{key} => [#{node.neighbors.map(&:value).join(",")}]"
    end
  end
end

@graph = Graph.new

lines.each do |line|
  split = line.chomp.split('-')
  @graph.add_edge(split[0], split[1])
end

@graph.print_edges

def find_paths(graph, current_value, current_path, used_small)
  if current_value == 'end'
    current_path + [current_value]
    puts current_path.join(",")

    1
  elsif current_value == 'start' && current_path.include?('start')
    0
  elsif graph.nodes[current_value].small_cave? && current_path.include?(current_value) && used_small
    0
  elsif graph.nodes[current_value].small_cave? && current_path.include?(current_value) && !used_small
    total = 0

    graph.nodes[current_value].neighbors.each do |neighbor|
      total += find_paths(graph, neighbor.value, current_path + [current_value], true)
    end

    total
  else
    neighbors = graph.nodes[current_value].neighbors

    total = 0
    neighbors.each do |neighbor|
      total += find_paths(graph, neighbor.value, current_path + [current_value], used_small)
    end

    total
  end
end

total = find_paths(@graph, 'start', [], false)
puts total