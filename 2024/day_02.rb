# frozen_string_literal: true

require_relative 'base'

class Day02 < Base # rubocop:disable Style/Documentation
  def day
    @day ||= '02'
  end

  def parse_input(input)
    input.split("\n").map { |x| x.split(/\s+/).map(&:to_i) }
  end

  def part_1(file) # rubocop:disable Naming/VariableNumber
    parsed = parse_input(file)

    count = 0
    parsed.each do |level|
      count += 1 if check_level_order(level) && check_level_distance(level)
    end
    count
  end

  def part_2(input) # rubocop:disable Naming/VariableNumber
    parsed = parse_input(input)

    count = 0
    parsed.each do |level|
      count += 1 if check_drop_one(level)
    end
    count
  end

  def check_level_order(level) # rubocop:disable Metrics/MethodLength
    up = 0
    down = 0
    (0..level.length - 2).each do |i|
      down += 1 if level[i] > level[i + 1]
      up += 1 if level[i] < level[i + 1]
    end

    if up.zero? || down.zero?
      true
    else
      false
    end
  end

  def check_drop_one(level)
    return true if check_level_order(level) && check_level_distance(level)

    level.length.times do |i|
      dupped = level.dup
      dupped.delete_at(i)
      return true if check_level_order(dupped) && check_level_distance(dupped)
    end

    false
  end

  def check_level_distance(level) # rubocop:disable Metrics/MethodLength
    x = 0
    y = 1
    positive = (level[-1] - level[0]).positive?

    while y < level.length
      value = if positive
                level[y] - level[x]
              else
                level[x] - level[y]
              end

      return false if value > 3 || value.zero?

      x += 1
      y += 1
    end

    true
  end
end

day = Day02.new

puts "Example 1: #{day.part_1(day.example_input_a)}"
puts "Part 1: #{day.part_1(day.input)}"
puts "Example 2: #{day.part_2(day.example_input_a)}"
puts "Part 2: #{day.part_2(day.input)}"
