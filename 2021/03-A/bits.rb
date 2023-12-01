lines = File.readlines('input.txt')

l = lines[0].chomp.length

bits = []
offbits = []

(0..l-1).each do |i|
  total = lines.map { |line| line[i].to_i }.sum

  if total > lines.length / 2
    bits << 1
    offbits << 0
  else
    bits << 0
    offbits << 1
  end
end

f = bits.join("").to_i(2)
s = offbits.join("").to_i(2)

puts f
puts s

puts f * s