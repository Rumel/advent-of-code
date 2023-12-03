require_relative './base.rb'

class Day02 < Base
  def day
    "02"
  end

  def parsed_input(input)
    result = []

    input.split("\n").map(&:strip).each do |line|
      split = line.split(":")

      game_nu = split[0].split(" ")[1].to_i
      colors = {}
      split[1].split(";").each do |grabs|
        grabs.split(",").map(&:strip).each do |grab|
          color = grab.split(" ")
          if colors[color[1]]
            if color[0].to_i > colors[color[1]]
              colors[color[1]] = color[0].to_i
            end
          else
            colors[color[1]] = color[0].to_i
          end
        end
      end
      result << [game_nu, colors]
    end

    result
  end

  def part_1(file)
    parsed = parsed_input(file)

    # only 12 red cubes, 13 green cubes, and 14 blue cubes?
    sum = 0
    parsed.each do |game|
      if game[1]["red"] <= 12 && game[1]["green"] <= 13 && game[1]["blue"] <= 14
        sum += game[0]
      end
    end

    sum
  end

  def part_2(file)
    parsed = parsed_input(file)

    sum = 0
    parsed.each do |game|
      sum += game[1]["red"] * game[1]["blue"] * game[1]["green"]
    end
    sum
  end
end

day = Day02.new
puts "Example 1: #{day.part_1(day.example_input_a)}"
puts "Part 1: #{day.part_1(day.input)}"
puts "Example 2: #{day.part_2(day.example_input_a)}"
puts "Part 2: #{day.part_2(day.input)}"