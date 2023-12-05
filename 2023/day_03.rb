require_relative './base'

class Day03 < Base
  def day
    '03'
  end

  NUMBERS = ('0'..'9').to_a.freeze

  def number?(char)
    NUMBERS.include?(char)
  end

  def symbol?(char)
    !NUMBERS.include?(char) && char != '.' && !char.nil?
  end

  def parse_input(input)
    numbers = []

    input.split("\n").each_with_index do |line, y|
      current_num = ''
      line.split('').each_with_index do |char, x|
        if number?(char)
          current_num += char
        elsif current_num != ''
          numbers << {
            number: current_num.to_i,
            x_start: x - current_num.length,
            y_start: y,
            x_end: x - 1,
            y_end: y
          }
          current_num = ''
        end
      end

      next unless current_num != ''

      numbers << {
        number: current_num.to_i,
        x_start: line.length - current_num.length,
        y_start: y,
        x_end: line.length - 1,
        y_end: y
      }
    end

    { numbers:, lines: input.split("\n").map { |line| line.split('') } }
  end

  def part1(input)
    parsed = parse_input(input)

    nums = []
    height = parsed[:lines].length
    width =  parsed[:lines].first.length
    parsed[:numbers].each do |value|
      x_range = (value[:x_start].positive? ? value[:x_start] - 1 : 0)..(value[:x_end] + 1 == width ? value[:x_end] : value[:x_end] + 1)
      y_range = (value[:y_start] > 0 ? value[:y_start] - 1 : value[:y_start])..(value[:y_end] + 1 == height ? value[:y_end] : value[:y_end] + 1)
      found_symbol = false
      y_range.each do |y|
        x_range.each do |x|
          current = parsed[:lines][y] && parsed[:lines][y][x]
          found_symbol = true if symbol?(current)
        end
      end

      nums << value[:number] if found_symbol
    end
    nums.sum
  end

  def part2; end
end

day = Day03.new
puts "Example: #{day.part1(day.example_input_a)}"
puts "Part 1: #{day.part1(day.input)}"
