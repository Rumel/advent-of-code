# frozen_string_literal: true

require_relative 'base'

class Day06 < Base # rubocop:disable Style/Documentation
  def day
    @day ||= '06'
  end

  def parse_input(input)
    lines = input.split("\n").map { |x| x.split('') }

    graph = {}
    graph['board'] = {}
    graph['rows'] = lines.length
    graph['columns'] = lines[0].length
    board = graph['board']
    lines.each_with_index do |line, y|
      line.each_with_index do |column, x|
        case column
        when '^'
          graph['starting_position'] = [x, y]
          board[[x, y]] = { visited: true, obstruction: false }
        when '#'
          board[[x, y]] = { visited: false, obstruction: true }
        when '.'
          board[[x, y]] = { visited: false, obstruction: false }
        end
      end
    end
    graph
  end

  def part_1(file) # rubocop:disable Naming/VariableNumber
    graph = parse_input(file)
    board = graph['board']
    directions = [[0, -1], [1, 0], [0, 1], [-1, 0]].cycle
    current_direction = directions.next
    position = graph['starting_position']

    loop do
      next_position_point = [position[0] + current_direction[0], position[1] + current_direction[1]]
      # puts next_position_point.inspect
      next_position = board[next_position_point]

      break unless next_position

      if next_position[:obstruction]
        current_direction = directions.next
      else
        position = next_position_point
        next_position[:visited] = true
        board[next_position_point] = next_position
      end
    end

    board.values.select { |x| x[:visited] }.length
  end

  def part_2(file) # rubocop:disable Naming/VariableNumber
    graph = parse_input(file)
  end
end

day = Day06.new

puts "Example 1: #{day.part_1(day.example_input_a)}"
puts "Part 1: #{day.part_1(day.input)}"
# puts "Example 2: #{day.part_2(day.example_input_a)}"
# puts "Part 2: #{day.part_2(day.input)}"
