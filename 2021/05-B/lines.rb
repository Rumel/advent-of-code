# lines = File.readlines('sample.txt')
# NUM = 9
lines = File.readlines('input.txt')
NUM = 999

arr = []

def print_arr(arr)
  arr.each do |line|
    puts line.join(" ")
  end

  puts "\n"
end



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
  else
    # diagonal
    # always start on the left
    diff = (start[0] - stop[0]).abs

    if start[0] < stop[0]
      startX, endX = start[0], stop[0]
      startY, endY = start[1], stop[1]
    else
      startX, endX = stop[0], start[0]
      startY, endY = stop[1], start[1]
    end

    if startY < endY
      (0..diff).each do |i|
        arr[startY + i][startX + i] += 1
      end
    else
      (0..diff).each do |i|
        arr[startY - i][startX + i] += 1
      end
    end
  end
end

# print_arr(arr)

puts arr.flatten.select { |x| x > 1 }.count