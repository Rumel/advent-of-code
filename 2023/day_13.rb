require_relative './base'
require 'digest'

class Pattern
  attr_reader :lines

  def rows
    @rows ||= []
  end

  def columns
    @columns ||= []
  end

  def row_hashes
    @row_hashes ||= []
  end

  def column_hashes
    @column_hashes ||= []
  end

  def initialize(lines)
    @lines = lines

    lines.each do |l|
      row_hashes << Digest::MD5.hexdigest(l)
      rows << l.split('')
    end

    length = lines.first.length
    (0...length).each do |i|
      chars = lines.map { |l| l[i] }
      column_hashes << Digest::MD5.hexdigest(chars.join(''))
      columns << chars
    end
  end

  def check_diffs(a, b)
    diffs = 0
    a.each_with_index do |d, i|
      d.each_with_index do |c, j|
        diffs += 1 if c != b[i][j]
      end
    end

    diffs
  end

  def reflection_point(data, tolerance)
    length = data.length
    midway_point = length / 2

    result = nil
    (1..(length - 1)).each do |i|
      if i <= midway_point
        if check_diffs(data[0..(i - 1)], data[i..(i + i - 1)].reverse) == tolerance
          result = i
          break
        end
      else
        dist = length - i
        if check_diffs(data[(i - dist)..(i - 1)], data[i..(i + dist - 1)].reverse) == tolerance
          result = i
          break
        end
      end
    end

    result || 0
  end

  def horizontal_reflection_point(tolerance = 0)
    reflection_point(rows, tolerance)
  end

  def vertical_reflection_point(tolerance = 0)
    reflection_point(columns, tolerance)
  end

  def score(tolerance = 0)
    (horizontal_reflection_point(tolerance) * 100) + vertical_reflection_point(tolerance)
  end
end

class Day13 < Base
  def day
    '13'
  end

  def parse_input(input)
    patterns = []

    current_lines = []
    input.split("\n").each do |line|
      if line == ''
        patterns << Pattern.new(current_lines)
        current_lines = []
      else
        current_lines << line
      end
    end
    patterns << Pattern.new(current_lines)

    patterns
  end

  def part_1(input)
    data = parse_input(input)

    data.sum { |d| d.score(0) }
  end

  def part_2(input)
    data = parse_input(input)

    data.sum { |d| d.score(1) }
  end
end

day = Day13.new
puts "Example: #{day.part_1(day.example_input_a)}"
puts "Part 1: #{day.part_1(day.input)}"
puts "Example: #{day.part_2(day.example_input_a)}"
puts "Part 2: #{day.part_2(day.input)}"
