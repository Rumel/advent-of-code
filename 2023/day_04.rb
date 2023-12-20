# frozen_string_literal: true

require_relative 'base'

class Day04 < Base
  def day
    '04'
  end

  def parse_input(input)
    games = []
    input.split("\n").each do |line|
      game_line = line.split(':')[1]
      game_split = game_line.split('|').map(&:strip)
      game = {}
      game[:winning_numbers] = game_split[0].split.map(&:to_i)
      game[:player_numbers] = game_split[1].split.map(&:to_i)
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
      next unless found.positive?

      current = 2**(found - 1)
      sum += current
    end
    sum
  end

  def part2(input)
    parsed = parse_input(input)

    parsed.each do |game|
      found = 0
      game[:winning_numbers].each do |winning_number|
        found += 1 if game[:player_numbers].include?(winning_number)
      end
      game[:num_matches] = found

      game[:value] = if found.positive?
                       2**(found - 1)
                     else
                       0
                     end
    end

    games = parsed.map do |game|
      game[:instances] = 1
      game
    end

    games.each_with_index do |game, index|
      next unless (game[:num_matches]).positive?

      (1..(game[:num_matches])).each do |i|
        current = games[index + i]
        current[:instances] += (1 * game[:instances]) unless current.nil?
      end
    end

    # 1 instance of card 1,
    # 2 instances of card 2,
    # 4 instances of card 3,
    # 8 instances of card 4,
    # 14 instances of card 5,
    # 1 instance of card 6.
    # 30 scratchcards!

    games.map { |game| game[:instances] }.sum
  end
end

day = Day04.new
puts "Example 1: #{day.part1(day.example_input_a)}"
puts "Part 1: #{day.part1(day.input)}"
puts "Example 2: #{day.part2(day.example_input_a)}"
puts "Part 2: #{day.part2(day.input)}"
