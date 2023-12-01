# lines = File.readlines('sample.txt')
lines = File.readlines('input.txt')

class Fish
  attr_accessor :timer

  def initialize(timer)
    @timer = timer
  end

  def new_day
    @timer -= 1

    if @timer == -1
      @timer = 6
      Fish.new(8)
    else
      nil
    end
  end
end

# DAYS = 18
# DEBUG = true
DAYS = 80
DEBUG = false

fish = lines[0].split(',').map(&:to_i).map { |x| Fish.new(x) }

puts fish.map(&:timer).join(',')

new_fish = []
(1..DAYS).each do |day|
  new_fish = fish.map(&:new_day).select { |f| f != nil }

  fish = fish.append(new_fish).flatten

  if DEBUG
    puts "After Day #{day}: #{fish.map(&:timer).join(',')}"
  end
end

puts fish.length