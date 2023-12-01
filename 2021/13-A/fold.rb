lines = File.readlines('input.txt')
lines = File.readlines('input.txt')

@arr = []

def print_arr(arr = @arr)
  puts "Paper"
  arr.each do |line|
    puts line.map { |value| value ? "#" : "." }.join
  end
  puts "\n"
end

point_lines = lines.select { |line| line.include?(',') }
fold_lines = lines.select { |line| line =~ /^fold/ }
points = point_lines.map { |line| split = line.split(','); split.map(&:to_i) }
max_x = points.map { |point| point[0] }.max
max_y = points.map { |point| point[1] }.max

(0..max_y).each do |y|
  k = []
  (0..max_x).each do |x|
    k << false
  end
  @arr << k
end

points.each do |x, y|
  @arr[y][x] = true
end

def fold_left(crease)
  dup = @arr.dup
  dup = dup.map { |line| line.reverse }
  rows = dup.length

  new_arr = []

  (0..rows-1).each do |y|
    row = []
    (0..crease-1).each do |x|
      row << (dup[y][x] || @arr[y][x])
    end
    new_arr << row
  end
  
  @arr = new_arr
end

def fold_up(crease)
  dup = @arr.dup
  dup = dup.reverse

  cols = dup[0].length

  new_arr = []

  (0..crease-1).each do |y|
    row = []
    (0..cols-1).each do |x|
      row << (@arr[y][x] || dup[y][x])
    end
    new_arr << row
  end

  @arr = new_arr
end 

fold_lines.each do |line|
  puts line
  split = line.split(' ')
  split = split[2].split("=")
  if split[0] == "y"
    fold_up(split[1].to_i)
  else
    fold_left(split[1].to_i)
  end

  puts @arr.map { |row| row.select { |value| value == true}.length }.sum
end

print_arr