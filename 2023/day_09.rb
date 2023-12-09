require_relative './base'

class Day09 < Base
  def day
    '09'
  end

  def parse_input(input)
    input.split("\n").map do |line|
      line.split(' ').map(&:to_i)
    end
  end

  def part1(input)
    data = parse_input(input)

    next_value = []
    data.each do |line|
      length = line.length
      finished = false
      finals = []
      finals << line.last
      current = line
      until finished
        i = 0
        diffs = []
        while i < current.length - 1
          diffs << current[i + 1] - current[i]
          i += 1
        end
        finished = diffs.all? 0
        current = diffs
        finals << current.last
      end
      next_value << finals.sum
    end
    next_value.sum
  end

  def part2(input)
    data = parse_input(input)
  end
end

day = Day09.new
puts "Example: #{day.part1(day.example_input_a)}"
puts "Part 1: #{day.part1(day.input)}"
