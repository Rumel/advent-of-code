# lines = File.readlines('sample.txt')
lines = File.readlines('input.txt')

arr = lines.map { |line| line.chomp.split('').map(&:to_i) }

low_points = []

puts arr.inspect

arr.each_with_index do |row, y|
  row.each_with_index do |col, x|
    check = []

    # top
    if y > 0
      check << arr[y-1][x]
    end

    # bottom
    if y < arr.length - 1
      check << arr[y+1][x]
    end

    # left
    if x > 0 
      check << arr[y][x-1]
    end
    
    # right
    if x < arr[y].length - 1
      check << arr[y][x+1]
    end

    if check.all? { |num| num > col }
      low_points << col + 1
    end
  end
end

puts low_points.inspect

puts low_points.sum