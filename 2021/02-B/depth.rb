lines = File.readlines('input.txt')

depth = 0
distance = 0
aim = 0

i = 0

lines.each do |line|
  split = line.split(" ")
  puts line

  if split[0] == "forward"
    distance += split[1].to_i
    depth_increase = aim * split[1].to_i
    depth += depth_increase
  elsif split[0] == "down"
    # depth += split[1].to_i
    aim += split[1].to_i
  else
    # depth -= split[1].to_i
    aim -= split[1].to_i
  end

  dict = { depth: depth, distance: distance, aim: aim }

  puts dict.inspect

  # i += 1
  # if i == 10
  #   break
  # end
end

puts depth * distance