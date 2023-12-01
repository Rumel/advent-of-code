# lines = File.readlines('sample.txt')
lines = File.readlines('input.txt')

DAYS = 256
DEBUG = true
# DAYS = 80
# DEBUG = true

school = Hash.new(0)

lines[0].split(',').each do |f|
  school[f.to_i] += 1
end

puts school

(1..DAYS).each do |day|
  new_school = Hash.new(0)
  school.each do |k, v|
    if k == 0
      new_school[8] += school[k]
      new_school[6] += school[k]
    else
      new_school[k-1] += school[k]
    end
  end

  school = new_school

  puts "Day #{day}: #{school.values.sum}" if DEBUG
end