# frozen_string_literal: true

require_relative 'base'

class Point
  attr_accessor :x, :y, :directions, :connected_points

  def initialize(x, y, pipe_symbol)
    @x = x
    @y = y
    @connected_points = []
    init_pipe_directions(pipe_symbol)
    init_connected_points
  end

  def point
    @point ||= "#{x},#{y}"
  end

  def inspect
    "#{point} - #{directions.inspect} - #{connected_points_s}"
  end

  def start?
    directions.include?(:start)
  end

  def ground?
    directions.include?(:ground)
  end

  private

  def init_pipe_directions(pipe_symbol)
    # Don't worry if it goes off board yet
    @directions = case pipe_symbol
                  when '|'
                    %i[north south]
                  when '-'
                    %i[east west]
                  when 'L'
                    %i[north east]
                  when 'J'
                    %i[north west]
                  when '7'
                    %i[south west]
                  when 'F'
                    %i[south east]
                  when '.'
                    [:ground]
                  when 'S'
                    [:start]
                  else
                    raise "Unknown pipe type: #{pipe_symbol}"
                  end
  end

  def init_connected_points
    @directions.each do |direction|
      case direction
      when :north
        @connected_points << [x, y - 1]
      when :south
        @connected_points << [x, y + 1]
      when :east
        @connected_points << [x + 1, y]
      when :west
        @connected_points << [x - 1, y]
      when :start
        @connected_points << [x, y]
      end
    end
  end

  def connected_points_s
    @connected_points_s ||= "[#{connected_points.map { |p| "(#{p[0]},#{p[1]})" }.join(',')}]"
  end
end

class Day10 < Base
  def day
    '10'
  end

  def parse_input(input)
    lines = input.split("\n")

    fields = {}

    lines.each_with_index do |line, y|
      line.each_char.with_index do |char, x|
        fields["#{x},#{y}"] = Point.new(x, y, char)
      end
    end

    fields
  end

  def part1(input)
    fields = parse_input(input)

    starting = fields.values.find(&:start?)

    loop_steps = []
    [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |direction|
      current_x = starting.x + direction[0]
      current_y = starting.y + direction[1]
      current = fields["#{current_x},#{current_y}"]

      next if current.nil?

      data = { steps: 0, finished: false, current: [current_x, current_y], previous: [starting.x, starting.y] }
      data = follow_path(fields, data) until data[:finished]

      loop_steps << data[:steps]
    end

    loop_steps.max / 2
  end

  def follow_path(fields, data)
    cur = "#{data[:current][0]},#{data[:current][1]}"

    previous = data[:current]
    next_point = fields[cur].connected_points.reject { |p| p == data[:previous] }.first

    if fields[cur].nil? ||
       fields[cur].ground? ||
       (!fields[cur].connected_points.include?(data[:previous]) && !fields[cur].start?)
      { steps: 0, finished: true, current: nil, previous: }
    elsif fields[cur].start?
      { steps: data[:steps] + 1, finished: true, current: nil, previous: }
    else
      { steps: data[:steps] + 1, finished: false, current: next_point, previous: }
    end
  end

  def part2(input)
    parse_input(input)
  end
end

day = Day10.new
puts "Example: #{day.part1(day.example_input_a)}"
puts "Part 1: #{day.part1(day.input)}"
# puts "Example: #{day.part2(day.example_input_a)}"
# puts "Part 2: #{day.part2(day.input)}"
