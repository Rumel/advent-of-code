# frozen_string_literal: true

require_relative 'base'

class Day08 < Base
  def day
    '08'
  end

  def parse_input(input)
    lines = input.split("\n")

    directions = lines[0].chars

    nodes = {}
    lines[2..].each do |line|
      split = line.split('=').map(&:strip)
      node = split[0]
      children = split[1].gsub(/[()\s]/, '').split(',')
      left = children[0]
      right = children[1]
      nodes[node] = { 'L' => left, 'R' => right }
    end

    { directions:, nodes: }
  end

  def part1(input)
    data = parse_input(input)

    steps = 0
    directions_cycle = data[:directions].cycle
    nodes = data[:nodes]
    current = 'AAA'
    loop do
      break if current == 'ZZZ'

      direction = directions_cycle.next
      current = nodes[current][direction]

      steps += 1
    end

    steps
  end

  def part2(input)
    data = parse_input(input)

    nodes = data[:nodes]
    currents = nodes.keys.select { |k| k.end_with?('A') }

    steps_arr = []
    currents.each do |current|
      directions_cycle = data[:directions].cycle
      steps = 0
      loop do
        break if current.end_with?('Z')

        direction = directions_cycle.next
        current = nodes[current][direction]

        steps += 1
      end

      steps_arr << steps
    end

    steps_arr.reduce(1, :lcm)
  end
end

day = Day08.new
puts "Example: #{day.part1(day.example_input_a)}"
puts "Part 1: #{day.part1(day.input)}"
puts "Example 2: #{day.part2(day.example_input_b)}"
puts "Part 2: #{day.part2(day.input)}"
