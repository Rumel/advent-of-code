require 'pry'
# Build Array
# lines = File.readlines("sample.txt")
lines = File.readlines("input.txt")

@board = []

def print_board
  @board.each do |row|
    puts row.map { |r| "%2d" % r.energy_level }.join " "
  end
  puts "\n"
end

class Octopus
  attr_accessor :energy_level, :x, :y, :flashed, :flash_count, :board, :x_limit, :y_limit

  def initialize(energy_level = 0, x = 0, y = 0, x_limit = 0, y_limit = 0, board = [])
    @energy_level = energy_level
    @x = x
    @y = y
    @flashed = false
    @flash_count = 0
    @board = board
    @x_limit = x_limit
    @y_limit = y_limit
  end

  def increase_energy_level(amount = 1)
    @energy_level += amount
  end

  def to_s
    "#{energy_level}"
  end

  def inspect
    to_s
  end

  def reset_flashed
    if @flashed
      @flash_count += 1
      @flashed = false
      @energy_level = 0
    end
  end

  def get_flash_radius
    if @energy_level > 9
      @flashed = true

      ret = []
      # left
      if @x > 0
        ret << @board[@y][@x - 1]
      end

      # right
      if @x < @x_limit - 1
        ret << @board[@y][@x + 1]
      end

      # up
      if @y > 0
        ret << @board[@y - 1][@x]
      end

      # down
      if @y < @y_limit - 1
        ret << @board[@y + 1][@x]
      end

      # top left
      if @x > 0 && @y > 0
        ret << @board[@y - 1][@x - 1]
      end

      # top right
      if @x < @x_limit - 1 && @y > 0
        ret << @board[@y - 1][@x + 1]
      end
      
      # bottom left
      if @y < @y_limit - 1 && @x > 0
        ret << @board[@y + 1][@x - 1]
      end

      # bottom right
      if @y < @y_limit - 1 && @x < @x_limit - 1
        ret << @board[@y + 1][@x + 1]
      end

      ret
    else
      []
    end
  end
end

@x_limit = lines[0].chomp.length
@y_limit = lines.length

lines.each_with_index do |line, y|
  row = []
  line.chomp.split("").each_with_index do |char, x|
    row << Octopus.new(char.to_i, x, y, @x_limit, @y_limit, @board)
  end
  @board << row
end

(1..1000).each do |i|
  @board.each { |row| row.each { |octopus| octopus.increase_energy_level } }

  keep_going = true
  while keep_going
    flashed = []
    @board.each { |row| row.each { |octopus| !octopus.flashed ? flashed << octopus.get_flash_radius : [] } }
    flashed = flashed.flatten.select { |octopus| !octopus.flashed }

    # print_board

    flashed.each do |octopus|
      octopus.increase_energy_level
    end

    keep_going = false if flashed.length == 0
  end

  @board.each { |row| row.each { |octopus| octopus.reset_flashed } }
  puts "Round #{i}"
  print_board
end

sum = @board.map { |row| row.map { |octopus| octopus.flash_count } }.flatten.sum

puts sum