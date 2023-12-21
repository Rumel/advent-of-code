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

    boxes = []
    256.times do |i|
      boxes[i] = []
    end

    data.each do |lens|
      split = lens.split(/=|-/)
      lens_name = split[0]
      focal_point = split[1]&.to_i

      cur = 0
      lens_name.chars.each do |c|
        ord = c.ord
        cur = ((cur + ord) * 17) % 256
      end

      if lens.include?('=')
        index = boxes[cur].find_index { |x| x[0] == lens_name }
        if index
          boxes[cur][index][1] = focal_point
        else
          boxes[cur].push([lens_name, focal_point])
        end
      else
        boxes[cur].delete_if { |b| b[0] == lens_name }
      end
    end

    total = 0
    boxes.each_with_index do |box, i|
      box.each_with_index do |lens, j|
        lens_total = (i + 1) * (j + 1) * lens[1]
        total += lens_total
      end
    end

    total
  end
end

day = Day15.new
puts "Example: #{day.part_1(day.example_input_a)}"
puts "Example: #{day.part_1(day.input)}"
puts "Example: #{day.part_2(day.example_input_a)}"
puts "Part 2: #{day.part_2(day.input)}"
