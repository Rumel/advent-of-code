# frozen_string_literal: true

require_relative 'base'

class Day07 < Base # rubocop:disable Style/Documentation
  def day
    @day ||= '07'
  end

  def parse_input(input)
    lines = input.split("\n")
    data = []
    lines.each do |line|
      split = line.split(':')
      data << [
        split[0].to_i,
        split[1].split(' ').map(&:to_i)
      ]
    end
    data
  end

  def recurse(total, line, target)
    return false if total > target
    return true if line.empty? && total == target
    return false if line.empty?

    recurse(total + line[0], line[1..], target) || recurse(total * line[0], line[1..], target)
  end

  def part_1(file) # rubocop:disable Naming/VariableNumber
    data = parse_input(file)

    count = 0
    data.each do |target, line|
      count += target if recurse(line[0], line[1..], target)
    end
    count
  end

  def part_2(file) # rubocop:disable Naming/VariableNumber
    graph = parse_input(file)
  end
end

day = Day07.new

puts "Example 1: #{day.part_1(day.example_input_a)}"
puts "Part 1: #{day.part_1(day.input)}"
# puts "Example 2: #{day.part_2(day.example_input_a)}"
# puts "Part 2: #{day.part_2(day.input)}"
