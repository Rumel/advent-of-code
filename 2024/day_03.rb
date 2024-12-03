# frozen_string_literal: true

require_relative 'base'

class Day03 < Base # rubocop:disable Style/Documentation
  def day
    @day ||= '03'
  end

  def parse_input(input)
    input
  end

  def part_1(file) # rubocop:disable Naming/VariableNumber
    parsed = parse_input(file)

    total = 0

    s = parsed
    loop do
      matches = /mul\((\d{1,3}),(\d{1,3})\)/.match(s)
      break unless matches

      index = s.index(matches[0]) + matches[0].length
      total += matches[1].to_i * matches[2].to_i

      break if index >= s.length

      s = s[index..]
    end

    total
  end

  def part_2(file) # rubocop:disable Naming/VariableNumber
    parsed = parse_input(file)

    total = 0

    is_on = true
    s = parsed
    loop do
      matches = /(mul\((\d{1,3}),(\d{1,3})\))|(do\(\))|(don't\(\))/.match(s)
      break unless matches

      if matches[0] == 'do()'
        is_on = true
      elsif matches[0] == "don't()"
        is_on = false
      elsif is_on
        total += matches[2].to_i * matches[3].to_i
      end

      index = s.index(matches[0]) + matches[0].length

      break if index >= s.length

      s = s[index..]
    end

    total
  end
end

day = Day03.new

puts "Example 1: #{day.part_1(day.example_input_a)}"
puts "Part 1: #{day.part_1(day.input)}"
puts "Example 2: #{day.part_2(day.example_input_b)}"
puts "Part 2: #{day.part_2(day.input)}"
