# frozen_string_literal: true

require_relative 'base'

class Day14 < Base
  def day
    '14'
  end

  def parse_input(input)
    rolling_rocks = []
    sturdy_rocks = []

    width = 0
    lines = input.split("\n")
    height = lines.length

    lines.each_with_index do |line, y|
      chars = line.chars
      width = chars.length if width.zero?

      chars.each_with_index do |char, x|
        case char
        when '0'
          rolling_rocks << [x, y]
        when '#'
          sturdy_rocks << [x, y]
        end
      end
    end

    { rolling_rocks:, sturdy_rocks:, width:, height: }
  end

  def part_1(input)
    parse_input(input)
  end

  def part_2(input)
    parse_input(input)
  end
end

day = Day14.new
puts "Example: #{day}"
