# lines = File.readlines('sample.txt')
lines = File.readlines('input.txt')

def include_all?(s, s2)
  s2.chars.each do |c|
    return false unless s.include?(c)
  end

  true
end

total = 0

lines = lines.map do |line|
  numbers = {}

  reverse_numbers = {}

  split = line.split('|')
  sorted = split[0].chomp.split(" ").map { |x| x.split("").sort.join("") }.sort_by { |x| x.length }
  secret = split[1].chomp.split(" ").map { |x| x.split("").sort.join("") }

  one = sorted.select { |x| x.length == 2 }[0]
  numbers[1] = one
  reverse_numbers[one] = 1

  seven = sorted.select { |x| x.length == 3 }[0]
  numbers[7] = seven
  reverse_numbers[seven] = 7

  four = sorted.select { |x| x.length == 4 }[0]
  numbers[4] = four
  reverse_numbers[four] = 4

  eight = sorted.select { |x| x.length == 7 }[0]
  numbers[8] = eight
  reverse_numbers[eight] = 8

  zero_six_nine = sorted.select { |x| x.length == 6 }
  # 6 doesn't include all of 1
  six = zero_six_nine.select { |x| !include_all?(x, one) }[0]
  zero_six_nine.delete(six)
  numbers[6] = six
  reverse_numbers[six] = 6

  nine = zero_six_nine.select { |x| include_all?(x, four) }[0]
  zero_six_nine.delete(nine)
  numbers[9] = nine
  reverse_numbers[nine] = 9

  zero = zero_six_nine[0]
  numbers[0] = zero
  reverse_numbers[zero] = 0

  two_three_five = sorted.select { |x| x.length == 5 }
  three = two_three_five.select { |x| include_all?(x, one) }[0]
  two_three_five.delete(three)
  numbers[3] = three
  reverse_numbers[three] = 3

  five = two_three_five.select { |x| include_all?(six, x) }[0]
  two_three_five.delete(five)
  numbers[5] = five
  reverse_numbers[five] = 5

  two = two_three_five[0]
  numbers[2] = two
  reverse_numbers[two] = 2

#   0:      1:      2:      3:      4:
#   aaaa    ....    aaaa    aaaa    ....
#  b    c  .    c  .    c  .    c  b    c
#  b    c  .    c  .    c  .    c  b    c
#   ....    ....    dddd    dddd    dddd
#  e    f  .    f  e    .  .    f  .    f
#  e    f  .    f  e    .  .    f  .    f
#   gggg    ....    gggg    gggg    ....
 
#    5:      6:      7:      8:      9:
#   aaaa    aaaa    aaaa    aaaa    aaaa
#  b    .  b    .  .    c  b    c  b    c
#  b    .  b    .  .    c  b    c  b    c
#   dddd    dddd    ....    dddd    dddd
#  .    f  e    f  .    f  e    f  .    f
#  .    f  e    f  .    f  e    f  .    f
#   gggg    gggg    ....    gggg    gggg

  # puts sorted.join(" ")
  # puts secret.join(" ")

  s = ""
  secret.each do |x|
    s += reverse_numbers.has_key?(x) ? reverse_numbers[x].to_s : "?"
  end
  puts s

  total += s.to_i
  # puts numbers
  # puts reverse_numbers
  # break
end

puts total