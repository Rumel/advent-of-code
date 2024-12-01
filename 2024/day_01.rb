# frozen_string_literal: true

require_relative 'base'

class Day01 < Base
  def day
    @day ||= '01'
  end

  def parse_input(input)
    numbers = input.split("\n").map {|x| x.split(/\s+/).map(&:to_i) }
  end

  def part_1(file)
    parsed = parse_input(file)
    list_one = parsed.map { |x| x[0] }.sort
    list_two = parsed.map { |x| x[1] }.sort

    count = 0
    list_one.zip(list_two).each do |x, y|
      count += (y - x).abs
    end

    count
  end

  def part_2(input)
    parsed = parse_input(input)
    list_one = parsed.map { |x| x[0] }.sort
    list_two = parsed.map { |x| x[1] }.sort

    count = 0
    list_one.each do |i|
      l = list_two.select { |x| x == i }.length
      count += l * i
    end

    count
  end
end

day = Day01.new

puts "Example 1: #{day.part_1(day.example_input_a)}"
puts "Part 1: #{day.part_1(day.input)}"
puts "Example 2: #{day.part_2(day.example_input_b)}"
puts "Part 2: #{day.part_2(day.input)}"
