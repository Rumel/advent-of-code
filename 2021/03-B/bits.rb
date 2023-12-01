require 'pry'
lines = File.readlines('input.txt')

l = lines[0].chomp.length

cur = lines.dup

oxygen = nil
scrubber = nil

(0..l-1).each do |i|
  total = cur.map { |line| line[i].to_i }.sum

  puts "#{total}/#{cur.length}"

  if total.to_f >= cur.length / 2.0
    cur = cur.select { |line| line[i].to_i == 1 }
  else
    cur = cur.select { |line| line[i].to_i == 0 }
  end

  if cur.length == 1
    oxygen = cur[0]
    break
  end
end

cur = lines.dup

(0..l-1).each do |i|
  total = cur.map { |line| line[i].to_i }.sum

  puts "#{total}/#{cur.length} #{total/cur.length.to_f}"

  if total.to_f >= cur.length / 2.0
    puts "0"
    cur = cur.select { |line| line[i].to_i == 0 }
  else
    puts "1"
    cur = cur.select { |line| line[i].to_i == 1 }
  end

  if cur.length == 1
    scrubber = cur[0]
    break
  end
end

puts "Oxygen:   #{oxygen}"
puts "Scrubber: #{scrubber}"

puts "Oxygen:   #{oxygen.to_i(2)}"
puts "Scrubber: #{scrubber.to_i(2)}"

puts oxygen.to_i(2) * scrubber.to_i(2)