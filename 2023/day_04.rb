require_relative './base'

class Day04 < Base
  def day
    '04'
  end

  def parse_input(input)
    games = []
    input.split("\n").each do |line|
      game_line = line.split(':')[1]
      game_split = game_line.split('|').map { |x| x.strip }
      game = {}
      game[:winning_numbers] = game_split[0].split(' ').map(&:to_i)
      game[:player_numbers] = game_split[1].split(' ').map(&:to_i)
      games << game
    end
    games
  end

  def part1(input)
    parsed = parse_input(input)

    sum = 0
    parsed.each do |game|
      found = 0
      game[:winning_numbers].each do |winning_number|
        found += 1 if game[:player_numbers].include?(winning_number)
      end
      next unless found > 0

      current = 2**(found - 1)
      sum += current
    end
    sum
  end

  def part2(_input); end
end

day = Day04.new
puts "Example 1: #{day.part1(day.example_input_a)}"
puts "Part 1: #{day.part1(day.input)}"
