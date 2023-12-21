# frozen_string_literal: true

require_relative 'base'

class Rock
  attr_accessor :x, :y, :rolling

  def initialize(x, y, rolling)
    @x = x
    @y = y
    @rolling = rolling
  end

  def rolling?
    rolling
  end

  def point
    "#{x},#{y}"
  end

  def inspect
    rolling? ? 'O' : '#'
  end

  def to_s
    inspect
  end
end

class RockBoard
  attr_accessor :board, :width, :height

  def initialize(board, width, height)
    @board = board
    @width = width
    @height = height
  end

  def move_rocks(direction)
    x_change = 0
    y_change = 0
    sorted_rocks = []

    case direction
    when 'down'
      y_change = 1
      sorted_rocks = rolling_rocks.sort { |a, b| a[1].y <=> b[1].y }.reverse
    when 'up'
      y_change = -1
      sorted_rocks = rolling_rocks.sort { |a, b| a[1].y <=> b[1].y }
    when 'left'
      x_change = -1
      sorted_rocks = rolling_rocks.sort { |a, b| a[1].x <=> b[1].x }
    when 'right'
      x_change = 1
      sorted_rocks = rolling_rocks.sort { |a, b| a[1].x <=> b[1].x }.reverse
    end

    sorted_rocks.each do |rock|
      can_move = true
      current_x = rock[1].x
      current_y = rock[1].y

      while can_move
        current_rock = board["#{current_x},#{current_y}"]
        current_x += x_change
        current_y += y_change

        new_point = "#{current_x},#{current_y}"

        if board[new_point] || current_x.negative? || current_x >= width || current_y.negative? || current_y >= height
          can_move = false
        else
          board[new_point] = Rock.new(current_x, current_y, true)
          board.delete(current_rock.point)
        end
      end
    end
  end

  def rolling_rocks
    board.select { |_k, v| v.rolling? }
  end

  def print_board
    (0...height).each do |y|
      (0...width).each do |x|
        print board["#{x},#{y}"] || '.'
      end
      print "\n"
    end
  end

  def score
    values = []
    rolling_rocks.each do |rock|
      value = height - rock[1].y
      values << value
    end

    values.sum
  end
end

class Day14 < Base
  def day
    '14'
  end

  def parse_input(input)
    width = 0
    lines = input.split("\n")
    height = lines.length
    board = {}

    lines.each_with_index do |line, y|
      chars = line.chars
      width = chars.length if width.zero?

      chars.each_with_index do |char, x|
        case char
        when 'O'
          board["#{x},#{y}"] = Rock.new(x, y, true)
        when '#'
          board["#{x},#{y}"] = Rock.new(x, y, false)
        end
      end
    end

    RockBoard.new(board, width, height)
  end

  def part_1(input)
    board = parse_input(input)

    board.move_rocks('up')

    board.score
  end

  def part_2(input)
    data = parse_input(input)

    0
  end
end

day = Day14.new
puts "Example: #{day.part_1(day.example_input_a)}"
puts "Part 1: #{day.part_1(day.input)}"
