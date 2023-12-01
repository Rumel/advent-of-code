# lines = File.readlines('sample.txt')
lines = File.readlines('input.txt')
starting_string = lines[0].chomp

STEPS = 10

count = {}
generation = {}
current = {}

(2..lines.length-1).each do |i|
  split = lines[i].chomp.split(" -> ")
  other_split = split[0].split('')
  generation[split[0]] = ["#{other_split[0]}#{split[1]}", "#{split[1]}#{other_split[1]}"]
end

starting_string = starting_string.split('')
(0..starting_string.length-2).each do |i|
  s = "#{starting_string[i]}#{starting_string[i+1]}"
  if current[s]
    current[s] += 1
  else
    current[s] = 1
  end
end

(0..starting_string.length-1).each do |i|
  s = "#{starting_string[i]}"
  if count[s]
    count[s] += 1
  else
    count[s] = 1
  end
end

(1..STEPS).each do |i|
  new_current = {}
  current.each do |k,v|
    generation[k].each_with_index do |g, index|
      if index == 0
        if count[g[1]]
          count[g[1]] += v
        else
          count[g[1]] = v
        end
      end

      if new_current[g]
        new_current[g] += v
      else
        new_current[g] = v
      end
    end
  end
  current = new_current
end

puts current
puts count
cv = count.values.sort.reverse
puts cv.inspect
puts cv[0] - cv[cv.length - 1]