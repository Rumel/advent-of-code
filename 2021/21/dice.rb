# lines = File.readlines('sample.txt')
lines = File.readlines('input.txt')

starting = []

lines.each do |line|
  split = line.split(" ")
  starting << split[4].to_i
end

class Player
  attr_accessor :score, :position

  def initialize(score, position)
    @score = score
    @position = position
  end

  def over_threshold?
    @score >= 1000
  end

  def add_score(total)
    @position = (@position + total) % 10
    if @position == 0
      @position = 10
    end

    @score += @position
  end
end

class Dice
  attr_accessor :current, :total_rolls

  def initialize
    @current = 1
    @total_rolls = 0
  end

  def roll
    total = [get_mod(@current), get_mod(@current + 1), get_mod(@current + 2)].sum
    @current = get_mod(@current + 3)
    @total_rolls = @total_rolls + 3
    total
  end

  def get_mod(i)
    if i > 100
      i - 100
    else
      i
    end
  end
end

@players = starting.map { |s| Player.new(0, s) }

d = Dice.new

@current_player = 0
def get_current_player
  i = @current_player

  @current_player = (@current_player + 1) % @players.length

  i
end

while !@players.any? { |p| p.over_threshold? }
  total = d.roll
  @players[get_current_player()].add_score(total)
  puts @players.map { |p| p.score }.inspect
end

puts @players.map { |p| p.score }.inspect

if @players[0].score < @players[1].score
  puts @players[0].score * d.total_rolls
else
  puts @players[1].score * d.total_rolls
end