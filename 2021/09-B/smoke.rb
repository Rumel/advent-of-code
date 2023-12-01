# lines = File.readlines('sample.txt')
lines = File.readlines('input.txt')

arr = lines.map { |line| line.chomp.split('').map(&:to_i) }

low_points = []

@x_limit = arr[0].length
@y_limit = arr.length

def get_basin(arr, x, y)
  in_basin = []
  to_check = []
  visited = []

  to_check << [x, y]

  while to_check.empty? == false
    x, y = to_check.pop

    if x == -1 || x == @x_limit || y == -1 || y == @y_limit || arr[y][x] == 9 || visited.include?([x, y])
      to_check.delete([x, y])
    else
      visited << [x, y]
      in_basin << [x, y]

      to_check << [x + 1, y]
      to_check << [x - 1, y]
      to_check << [x, y + 1]
      to_check << [x, y - 1]

      to_check.delete([x, y])
    end
  end

  in_basin.length
end

basins = []
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
      visited = []
      basins << get_basin(arr, x, y)
    end
  end
end


basins = basins.sort.reverse
puts basins.inspect

puts basins[0] * basins[1] * basins[2]
