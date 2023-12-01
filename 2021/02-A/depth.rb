lines = File.readlines('input.txt')

depth = 0
distance = 0

lines.each do |line|
  split = line.split(" ")
  if split[0] == "forward"
    distance += split[1].to_i
  elsif split[0] == "down"
    depth += split[1].to_i
  else
    depth -= split[1].to_i
  end
end

puts depth * distance