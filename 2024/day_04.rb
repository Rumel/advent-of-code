# frozen_string_literal: true

require_relative 'base'

class Day04 < Base # rubocop:disable Style/Documentation
  def day
    @day ||= '04'
  end

  def parse_input(input)
    rows = input.split("\n").map(&:strip).map { |x| x.split('') }

    graph = {}
    rows.each_with_index do |row, y|
      row.each_with_index do |column, x|
        graph[[x, y]] = column
      end
    end

    graph['rows'] = rows.length
    graph['columns'] = rows[0].length
    graph
  end

  def check_direction(graph, x, y, xx, yy)
    'XMAS' == "#{graph[[x,
                        y]]}#{graph[[x + xx,
                                     y + yy]]}#{graph[[x + xx * 2, y + yy * 2]]}#{graph[[x + xx * 3, y + yy * 3]]}"
  end

  def part_1(file) # rubocop:disable Naming/VariableNumber
    graph = parse_input(file)
    rows = graph['rows']
    columns = graph['columns']

    count = 0
    (0..rows).each do |y|
      (0..columns).each do |x|
        count += 1 if check_direction(graph, x, y, -1, 0)
        count += 1 if check_direction(graph, x, y, 1, 0)
        count += 1 if check_direction(graph, x, y, 0, -1)
        count += 1 if check_direction(graph, x, y, 0, 1)
        count += 1 if check_direction(graph, x, y, 1, -1)
        count += 1 if check_direction(graph, x, y, 1, 1)
        count += 1 if check_direction(graph, x, y, -1, -1)
        count += 1 if check_direction(graph, x, y, -1, 1)
      end
    end

    count
  end

  def check_xmas_cross(graph, x, y) # rubocop:disable Metrics/AbcSize,Naming/MethodParameterName
    check = [graph[[x - 1, y - 1]] || '', graph[[x - 1, y + 1]] || '', graph[[x + 1, y - 1]] || '',
             graph[[x + 1, y + 1]] || ''].sort
    true if check == %w[M M S S] && graph[[x - 1, y - 1]] != graph[[x + 1, y + 1]]
  end

  def part_2(file) # rubocop:disable Naming/VariableNumber
    graph = parse_input(file)
    rows = graph['rows']
    columns = graph['columns']

    count = 0
    (0..rows).each do |y|
      (0..columns).each do |x|
        count += 1 if graph[[x, y]] == 'A' && check_xmas_cross(graph, x, y)
      end
    end

    count
  end
end

day = Day04.new

puts "Example 1: #{day.part_1(day.example_input_a)}"
puts "Part 1: #{day.part_1(day.input)}"
puts "Example 2: #{day.part_2(day.example_input_a)}"
puts "Part 2: #{day.part_2(day.input)}"
