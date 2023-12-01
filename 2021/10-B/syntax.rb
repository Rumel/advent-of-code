# lines = File.readlines('sample.txt')
lines = File.readlines('input.txt')

def opening_char?(char)
  char == '(' || char == '[' || char == '{' || char == '<'
end

def closing_char?(char)
  char == ')' || char == ']' || char == '}' || char == '>'
end

@brackets = {
  "]" => "[",
  ")" => "(",
  "}" => "{",
  ">" => "<"
}

@reverse_brackets = {
  "[" => "]",
  "(" => ")",
  "{" => "}",
  "<" => ">"
}

@bracket_points = {
  ")" => 1,
  "]" => 2,
  "}" => 3,
  ">" => 4
}

illegal_characters = []

scores = []

lines.each do |line|
  syntax = []
  illegal = false
  line.chomp.chars.each do |char|
    if opening_char?(char)
      syntax << char
    elsif closing_char?(char)
      opener = syntax.pop
      if @brackets[char] != opener
        illegal = true
        illegal_characters << char
        break
      end
    end
  end

  if !illegal
    total = 0
    endings = []
    syntax.reverse.each do |char|
      total = total * 5
      endings << @reverse_brackets[char]
      total += @bracket_points[@reverse_brackets[char]]
    end
    scores << total
  end
end

puts scores.inspect
scores = scores.sort
puts scores.length
x = scores.length / 2
puts scores[x]