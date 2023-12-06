require_relative './base'

class Day06 < Base
  def day
    '06'
  end

  def parse_input(input)
    lines = input.split("\n")

    times = lines[0].split(':').last.strip.split(' ').map(&:to_i)
    distances = lines[1].split(':').last.strip.split(' ').map(&:to_i)

    [times, distances]
  end

  def part1(input)
    data = parse_input(input)
    data = data[0].zip(data[1])

    values = []
    data.each do |d|
      time = d[0]
      distance = d[1]

      results = quadratic_formula(1, time * -1, distance)
      start = (results[0] + 1).floor
      end_value = (results[1] - 1).ceil

      values << end_value - start + 1
    end

    values.inject(:*)
  end

  def part2(input)
    data = parse_input(input)
    time = data[0].join('').to_i
    distance = data[1].join('').to_i

    results = quadratic_formula(1, time * -1, distance)
    start = (results[0] + 1).floor
    end_value = (results[1] - 1).ceil

    end_value - start + 1
  end

  private

  def quadratic_formula(a, b, c)
    first = ((-1 * b) - Math.sqrt((b**2) - (4 * a * c))) / (2 * a)
    second = ((-1 * b) + Math.sqrt((b**2) - (4 * a * c))) / (2 * a)

    [first, second]
  end
end

day = Day06.new
puts "Example: #{day.part1(day.example_input_a)}"
puts "Part 1: #{day.part1(day.input)}"
puts "Example: #{day.part2(day.example_input_a)}"
puts "Part 2 #{day.part2(day.input)}"
