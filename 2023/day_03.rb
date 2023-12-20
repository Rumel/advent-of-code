# frozen_string_literal: true

require_relative 'base'

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

  def gear?(char)
    char == '*'
  end

  def parse_input(input)
    numbers = []

    input.split("\n").each_with_index do |line, y|
      current_num = ''
      line.chars.each_with_index do |char, x|
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

    { numbers:, lines: input.split("\n").map(&:chars) }
  end

  def part1(input)
    parsed = parse_input(input)

    nums = []
    height = parsed[:lines].length
    width =  parsed[:lines].first.length
    parsed[:numbers].each do |value|
      x_range =
        (value[:x_start].positive? ? value[:x_start] - 1 : 0)..(
          value[:x_end] + 1 == width ? value[:x_end] : value[:x_end] + 1)
      y_range =
        ((value[:y_start]).positive? ? value[:y_start] - 1 : value[:y_start])..(
          value[:y_end] + 1 == height ? value[:y_end] : value[:y_end] + 1)
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

  def part2(input)
    parsed = parse_input(input)

    gear_nums = []
    height = parsed[:lines].length
    width =  parsed[:lines].first.length
    parsed[:numbers].each do |value|
      x_range =
        (value[:x_start].positive? ? value[:x_start] - 1 : 0)..(
          value[:x_end] + 1 == width ? value[:x_end] : value[:x_end] + 1)
      y_range =
        ((value[:y_start]).positive? ? value[:y_start] - 1 : value[:y_start])..(
          value[:y_end] + 1 == height ? value[:y_end] : value[:y_end] + 1)
      gear = nil
      y_range.each do |y|
        x_range.each do |x|
          current = parsed[:lines][y] && parsed[:lines][y][x]
          gear = { number: value[:number], gear: "#{x},#{y}" } if gear?(current)
          break if gear
        end
        gear_nums << gear if gear
        break if gear
      end
    end
    grouped = gear_nums.group_by { |gear| gear[:gear] }.select { |_, v| v.length > 1 }
    grouped.map { |_, v| v.map { |gear| gear[:number] }.reduce(&:*) }.sum
  end
end

day = Day03.new
puts "Example: #{day.part1(day.example_input_a)}"
puts "Part 1: #{day.part1(day.input)}"
puts "Example: #{day.part2(day.example_input_a)}"
puts "Part 2: #{day.part2(day.input)}"
