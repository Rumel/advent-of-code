require_relative './base'
require 'digest'

class Pattern
  attr_reader :lines

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
    end

    length = lines.first.length
    (0...length).each do |i|
      s = lines.map { |l| l[i] }.join
      column_hashes << Digest::MD5.hexdigest(s)
    end
  end

  def reflection_point(hashes)
    length = hashes.length
    midway_point = length / 2

    result = nil
    (1..(length - 1)).each do |i|
      if i <= midway_point
        if hashes[0..(i - 1)] == hashes[i..(i + i - 1)].reverse
          result = i
          break
        end
      else
        dist = length - i
        if hashes[(i - dist)..(i - 1)] == hashes[i..(i + dist - 1)].reverse
          result = i
          break
        end
      end
    end

    result || 0
  end

  def horizontal_reflection_point
    reflection_point(row_hashes)
  end

  def vertical_reflection_point
    reflection_point(column_hashes)
  end

  def score
    (horizontal_reflection_point * 100) + vertical_reflection_point
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

    data.sum(&:score)
  end

  def part_2(input)
    data = parse_input(input)
    0
  end
end

day = Day13.new
puts "Example: #{day.part_1(day.example_input_a)}"
puts "Part 1: #{day.part_1(day.input)}"
