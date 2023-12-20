# frozen_string_literal: true

require_relative 'base'

class Day01 < Base
  NUMBERS = ('1'..'9').to_a.freeze
  STRING_NUMBERS = [
    ['one', 1],
    ['two', 2],
    ['three', 3],
    ['four', 4],
    ['five', 5],
    ['six', 6],
    ['seven', 7],
    ['eight', 8],
    ['nine', 9]
  ].freeze

  def day
    @day ||= '01'
  end

  def parse_input(input)
    input.split("\n").map(&:strip)
  end

  def part_1(file)
    parsed = parse_input(file)

    sum = 0
    parsed.each do |line|
      values = line.chars.select { |c| NUMBERS.include?(c) }
      sum += "#{values.first}#{values.last}".to_i
    end
    sum
  end

  def part_2(input)
    parsed = parse_input(input)
    values = get_values(parsed)
    values.sum
  end

  def get_values(parsed)
    parsed.map do |line|
      first = nil
      last = nil

      i = 0
      while i < line.length
        first = line[i].to_i if line[i].to_i.positive?

        STRING_NUMBERS.each do |string_number|
          first = string_number.last if line[i..].start_with?(string_number.first)
        end

        break unless first.nil?

        i += 1

      end

      i = line.length - 1
      while i > -1
        last = line[i].to_i if line[i].to_i.positive?

        STRING_NUMBERS.each do |string_number|
          last = string_number.last if line[0..i].end_with?(string_number.first)
        end

        break unless last.nil?

        i -= 1

      end

      "#{first}#{last}".to_i
    end
  end
end

day = Day01.new

puts "Example 1: #{day.part_1(day.example_input_a)}"
puts "Part 1: #{day.part_1(day.input)}"
puts "Example 2: #{day.part_2(day.example_input_b)}"
puts "Part 2: #{day.part_2(day.input)}"
