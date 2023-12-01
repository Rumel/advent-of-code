require 'pry'

class Point
  attr_accessor :number, :marked

  def initialize(number)
    @number = number
    @marked = false
  end

  def marked?
    @marked
  end
end

class BingoList
  attr_accessor :numbers, :current

  def initialize(line)
    @current = 0
    @numbers = line.split(',').map { |number| number.to_i }
  end

  def next
    @current += 1
    @numbers[current - 1]
  end
end

class Board
 attr_accessor :board

 def initialize(lines)
    @board = []

    lines.each_with_index do |line, index|
      @board[index] = line.chomp.split("\s").map { |number| Point.new(number.to_i) }
    end
  end

  def mark_number(number)
    @board.each do |line|
      line.select { |point| point.number == number }.each { |point| point.marked = true }
    end
  end

  def bingo_horizontally?
    @board.each do |line|
      unmarked = line.select { |point| point.marked? == false }

      if unmarked.empty?
        return true
      end
    end

    false
  end

  def bingo_vertically?
    i = 0

    while i < 5
      unmarked = @board.map { |line| line[i] }.select { |point| point.marked? == false }

      if unmarked.empty?
        return true
      end

      i += 1
    end

    false
  end

  def bingo_diagonally?
    left = []
    right = []

    i = 0
    while i < 5
      left << @board[i][i]
      right << @board[i][4 - i]

      i += 1
    end

    [left, right].each do |check|
      unmarked = check.select { |point| point.marked? == false }

      if unmarked.empty?
        return true
      end
    end

    false
  end

  def bingo?
    bingo_horizontally? || bingo_vertically? # || bingo_diagonally?
  end

  def get_value(num)
    sum = @board.flatten.select { |point| point.marked? == false }.map { |point| point.number }.sum

    puts sum
    puts num

    sum * num
  end

  def to_s
    s = "Board\n"

    @board.each do |line|
      s += line.map { |point| "#{point.number}#{point.marked? ? "X" : ""}" }.join(' ')
      s += "\n"
    end

    s += "#{bingo? ? "Bingo" : "No Bingo"}\n"

    s
  end
end

lines = File.readlines('input.txt')
# lines = File.readlines('sample.txt')
boards = []
i = 0
bl = BingoList.new(lines[i])
i+=2
while i < lines.length
  boards << Board.new(lines.slice(i, 5))
  i += 6
end

cur = bl.next
while cur != nil
  puts cur
  boards.each do |board|
    board.mark_number(cur)
  end

  solved = boards.select { |board| board.bingo? }
  boards = boards.select { |board| !board.bingo? }
  if solved.length == 1 && boards.length == 0
    puts "Bingo"
    puts solved
    puts solved[0].get_value(cur)
    exit
  end

  cur = bl.next
end