# frozen_string_literal: true

require_relative 'base'

class Day05 < Base # rubocop:disable Style/Documentation
  def day
    @day ||= '05'
  end

  def parse_input(input)
    lines = input.split("\n")
    graph = {}

    graph['updates'] = []
    parse_number = true
    lines.each do |line|
      if line == ''
        parse_number = false
        next
      elsif parse_number
        numbers = line.split('|').map(&:to_i)
        if graph[numbers[0]]
          graph[numbers[0]] << numbers[1]
        else
          graph[numbers[0]] = [numbers[1]]
        end
      else
        graph['updates'] << line.split(',').map(&:to_i)
      end
    end

    graph
  end

  def get_value(graph, update)
    l = update.length
    x = 0
    while x < l - 1
      return 0 unless graph[update[x]]&.include?(update[x + 1])

      x += 1
    end

    update[l / 2]
  end

  def part_1(file) # rubocop:disable Naming/VariableNumber
    graph = parse_input(file)

    count = 0
    graph['updates'].each do |update|
      count += get_value(graph, update)
    end
    count
  end

  def part_2(file) # rubocop:disable Naming/VariableNumber
    graph = parse_input(file)
    second_graph = graph.dup
    second_graph.delete 'updates'
    order = second_graph.map { |k, v| [k, v.length] }.sort_by { |k, v| -v }.map(&:first)
    # order << second_graph.select { |k, v| v.length == 1 }.to_a[0][1][0]

    count = 0
    graph['updates'].each do |update|
      next unless get_value(graph, update) == 0

      new_order = []
      order.each do |o|
        new_order << o if update.include? o
      end
      l = new_order.length

      count += if l.even?
                 new_order[(l + 1) / 2]
               else
                 new_order[l / 2]
               end
    end

    count
  end
end

day = Day05.new

# puts "Example 1: #{day.part_1(day.example_input_a)}"
# puts "Part 1: #{day.part_1(day.input)}"
puts "Example 2: #{day.part_2(day.example_input_a)}"
puts "Part 2: #{day.part_2(day.input)}"
