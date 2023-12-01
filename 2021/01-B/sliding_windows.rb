lines = File.readlines('input.txt')

i = 0
l = lines.length

increased = 0

sums = []

while i < l - 2
  sums << lines[i].to_i + lines[i + 1].to_i + lines[i + 2].to_i

  i += 1
end

i = 0
l = sums.length

increased = 0

while i < l
  if sums[i] > sums[i-1]
    increased += 1
  end
  i += 1
end

puts increased