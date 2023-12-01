# lines = File.readlines('sample.txt')
lines = File.readlines('input.txt')

total = 0

lines.each_with_index do |line, i|
  split = line.split("|")
  rsplit = split[1].chomp.split(" ")
  result = rsplit.select { |x| x.length == 2 ||  x.length == 3 || x.length == 4 || x.length == 7 }
  puts "#{i}: #{result.join(" ")}"
  total += result.count
end

puts total