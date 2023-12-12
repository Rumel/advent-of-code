require_relative './base'

class Day11 < Base
  def day
    '11'
  end

  def parse_input(input)
    galaxies = []
    input.split("\n").each_with_index do |line, i|
      line.split('').each_with_index do |char, j|
        galaxies << [j, i] if char == '#'
      end
    end

    columns = galaxies.map(&:first).uniq
    rows = galaxies.map(&:last).uniq

    missing_columns = (0..(columns.max)).to_set.difference(columns.to_set)
    missing_rows = (0..(rows.max)).to_set.difference(rows.to_set)

    { galaxies:, columns: missing_columns, rows: missing_rows }
  end

  def part1(input)
    data = parse_input(input)

    galaxies = data[:galaxies]
    columns = data[:columns]
    rows = data[:rows]

    combinations = galaxies.combination(2).to_a

    distances = []
    combinations.each do |combo|
      x1, y1 = combo[0]
      x2, y2 = combo[1]

      row_intersection = if y2 > y1
                           rows.intersection((y1..y2).to_set).length
                         else
                           rows.intersection((y2..y1).to_set).length
                         end

      column_intersection = if x2 > x1
                              columns.intersection((x1..x2).to_set).length
                            else
                              columns.intersection((x2..x1).to_set).length
                            end

      distances << (y2 - y1).abs + (x2 - x1).abs + row_intersection + column_intersection
    end

    # Too low
    # 9504907

    distances.sum
  end

  def part2(input)
    data = parse_input(input)
    0
  end
end

day = Day11.new
puts "Example: #{day.part1(day.example_input_a)}"
puts "Part 1: #{day.part1(day.input)}"
