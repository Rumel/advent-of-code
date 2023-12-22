# frozen_string_literal: true

require_relative 'base'

class Board
  attr_accessor :board, :width, :height

  def visited_points
    @visited_points ||= Set.new
  end

  def visited?(x, y, x_dir, y_dir)
    visited_points.include?([[x, y], [x_dir, y_dir]])
  end

  def initialize(input)
    @height = input.length
    @width = input.first.length
    @board = {}

    input.each_with_index do |line, y|
      line.each_with_index do |char, x|
        @board[[x, y]] = char
      end
    end
  end

  def add_point(next_points, point, direction)
    next_point = [point[0] + direction[0], point[1] + direction[1]]

    if next_point[0].negative? || next_point[0] >= width || next_point[1].negative? || next_point[1] >= height
      next_points
    else
      next_points << [next_point, direction] unless visited?(next_point[0], next_point[1], direction[0], direction[1])
    end
  end

  def traverse_board
    current = [[[0, 0], [1, 0]]]

    until current.empty?
      next_points = []
      current.each do |point|
        visited_points << point

        case board[point[0]]
        when '.'
          add_point(next_points, point[0], point[1])
        when '|'
          if point[1] == [1, 0] || point[1] == [-1, 0]
            add_point(next_points, point[0], [0, 1])
            add_point(next_points, point[0], [0, -1])
          else
            add_point(next_points, point[0], point[1])
          end
        when '-'
          if point[1] == [0, 1] || point[1] == [0, -1]
            add_point(next_points, point[0], [1, 0])
            add_point(next_points, point[0], [-1, 0])
          else
            add_point(next_points, point[0], point[1])
          end
        when '/'
          case point[1]
          when [1, 0]
            add_point(next_points, point[0], [0, -1])
          when [-1, 0]
            add_point(next_points, point[0], [0, 1])
          when [0, 1]
            add_point(next_points, point[0], [-1, 0])
          when [0, -1]
            add_point(next_points, point[0], [1, 0])
          end
        when '\\'
          case point[1]
          when [1, 0]
            add_point(next_points, point[0], [0, 1])
          when [-1, 0]
            add_point(next_points, point[0], [0, -1])
          when [0, 1]
            add_point(next_points, point[0], [1, 0])
          when [0, -1]
            add_point(next_points, point[0], [-1, 0])
          end
        end
      end
      current = next_points
    end
  end

  def print_energized
    points = visited_points.map { |x| x[0] }.uniq

    (0..(height - 1)).each do |y|
      (0..(width - 1)).each do |x|
        if points.include? [x, y]
          print '#'
        else
          print '.'
        end
      end
      print "\n"
    end
    puts
  end
end

class Day16 < Base
  def day
    '16'
  end

  def parse_input(input)
    Board.new(input.split("\n").map(&:chars))
  end

  def part_1(input)
    board = parse_input(input)
    board.traverse_board
    # board.print_energized

    board.visited_points.map { |x| x[0] }.uniq.length
  end

  def part_2(input)
    data = parse_input(input)
    0
  end
end

day = Day16.new
puts "Example: #{day.part_1(day.example_input_a)}"
puts "Example: #{day.part_1(day.input)}"
