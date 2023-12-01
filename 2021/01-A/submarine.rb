lines = File.readlines('input.txt')

i = 1
l = lines.length

increased = 0

while i < l
  if lines[i].chomp.to_i > lines[i-1].chomp.to_i
    increased += 1
  end
  i += 1
end

puts increased