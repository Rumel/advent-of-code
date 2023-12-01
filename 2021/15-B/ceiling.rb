require 'pry'
# lines = File.readlines('sample.txt')
lines = File.readlines('input.txt')

arr = []

lines.each do |line|
  arr << line.chomp.split('').map(&:to_i)
end

def build_giant_arr(arr)
  current_arr = arr.dup
  1..4.times do
    new_arr = current_arr.dup.map{ |row| row.map {|x| x = x + 1; x > 9 ? 1 : x } }
    current_arr = new_arr
    arr.each_with_index do |row, i|
      arr[i] = row + new_arr[i]
    end
  end

  current_arr = arr.dup
  1..4.times do
    new_arr = current_arr.dup.map{ |row| row.map {|x| x = x + 1; x > 9 ? 1 : x } }
    current_arr = new_arr
    # binding.pry
    (0..current_arr.length-1).each do |i|
      arr << new_arr[i]
    end
  end

  arr
end

class GraphNode
  attr_accessor :value, :neighbors, :x, :y

  def initialize(value, x, y)
    @value = value
    @x = x
    @y = y
    @neighbors = []
  end

  def coordinates
    "(#{@x},#{@y})"
  end

  def inspect
    "[#{@value}: #{coordinates} - [#{@neighbors.map(&:coordinates).join(' ')}]]"
  end
end

class Graph
  attr_accessor :nodes, :arr

  def initialize(arr)
    @arr = arr
    @nodes = []
    @arr.each_with_index do |row, row_index|
      row.each_with_index do |value, col_index|
        node = GraphNode.new(value, col_index, row_index)
        @nodes << node
      end
    end

    @arr.each_with_index do |row, row_index|
      row.each_with_index do |value, col_index|
        node = find_node(col_index, row_index)

        left = find_node(col_index - 1, row_index)
        right = find_node(col_index + 1, row_index)
        up = find_node(col_index, row_index - 1)
        down = find_node(col_index, row_index + 1)

        node.neighbors << left if left
        node.neighbors << right if right
        node.neighbors << up if up
        node.neighbors << down if down
      end
    end
  end

  def find_node(x,y)
    @nodes.find{ |node| node.x == x && node.y == y }
  end

  def inspect
    @nodes.map(&:inspect).join("\n")
  end
end

def dijkstra(graph, starting_node)
    unvisited_nodes = graph.nodes.dup

    shortest_paths = {}
    previous_nodes = {}

    infinity = Float::INFINITY

    unvisited_nodes.each do |node|
      shortest_paths[node] = infinity
    end

    shortest_paths[starting_node] = 0

    while unvisited_nodes.length > 0
      current_min_node = nil
      unvisited_nodes.each do |node|
        if current_min_node == nil
          current_min_node = node
        elsif shortest_paths[node] < shortest_paths[current_min_node]
          current_min_node = node
        end
      end

      current_min_node.neighbors.each do |neighbor|
        tentative_value = shortest_paths[current_min_node] + neighbor.value
        if tentative_value < shortest_paths[neighbor]
          shortest_paths[neighbor] = tentative_value
          previous_nodes[neighbor] = current_min_node
        end
      end

      unvisited_nodes.delete(current_min_node)
    end

    {
      :previous_nodes => previous_nodes,
      :shortest_paths => shortest_paths
    }
end

def print_result(previous_nodes, shortest_path, start_node, target_node)
  path = []
  node = target_node
  
  while node != start_node
      path << node
      node = previous_nodes[node]
  end

  # Add the start node manually
  path << start_node
  
  path = path.reverse
  puts path.map { |node| node.value }.join(' -> ')
  path.shift
  puts "Shortest path: #{path.map { |node| node.value }.sum}"
end

build_giant_arr(arr)

g = Graph.new(arr)

result = dijkstra(g, g.nodes.first)

print_result(result[:previous_nodes], result[:shortest_paths], g.nodes.first, g.nodes.last)