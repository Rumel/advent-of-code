lines = File.readlines('sample.txt')
lines = File.readlines('input.txt')

arr = []

def print_arr(arr)
  arr.each do |line|
    puts line.join(" ")
  end

  puts "\n"
end

NUM = 999

(0..NUM).each do |i|
  arr << []
  (0..NUM).each do |j|
    arr[i][j] = 0
  end
end

lines.each do |line|
  split = line.split(' -> ')
  start = split[0].chomp.split(',').map(&:to_i)
  stop = split[1].chomp.split(',').map(&:to_i)

  if start[1] == stop[1]
    # horizontal
    startX, endX = start[0] < stop[0] ? [start[0], stop[0]] : [stop[0], start[0]]

    (startX..endX).each do |i|
      arr[stop[1]][i] += 1
    end
  elsif start[0] == stop[0]
    # vertical

    startY, endY = start[1] < stop[1] ? [start[1], stop[1]] : [stop[1], start[1]]

    (startY..endY).each do |i|
      arr[i][stop[0]] += 1
    end
  end
end

puts arr.flatten.select { |x| x > 1 }.count