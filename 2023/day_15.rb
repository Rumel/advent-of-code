# frozen_string_literal: true

require_relative 'base'

class Day15 < Base
  def day
    '15'
  end

  def parse_input(input)
    splits = input.split(',')
  end

  def part_1(input)
    data = parse_input(input)

    results = []
    data.each do |d|
      cur = 0
      d.split('').each do |c|
        ord = c.ord
        cur = ((cur + ord) * 17) % 256
      end
      results << cur
    end

    results.sum
  end

  def part_2(input)
    data = parse_input(input)

    0
  end
end

day = Day15.new
puts "Example: #{day.part_1(day.example_input_a)}"
puts "Example: #{day.part_1(day.input)}"
