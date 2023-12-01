# nums = File.readlines('sample.txt')[0].split(",").map(&:to_i)
nums = File.readlines('input.txt')[0].split(",").map(&:to_i)

sorted = nums.sort

lowest = nil

i = 0
while i < sorted.length
  total = 0

  j = 0
  while j < sorted.length
    if i != sorted[j]
      abs = (i - sorted[j]).abs
      total += (0..abs).sum
    end

    j += 1
  end

  if lowest.nil? || total < lowest
    lowest = total
  end

  i += 1
end

puts lowest