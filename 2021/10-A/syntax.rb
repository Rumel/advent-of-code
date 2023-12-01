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

illegal_characters = []

lines.each do |line|
  syntax = []
  line.chomp.chars.each do |char|
    if opening_char?(char)
      syntax << char
    elsif closing_char?(char)
      opener = syntax.pop
      if @brackets[char] != opener
        illegal_characters << char
        break
      end
    end
  end
end

@points = {
  ")" => 3,
  "]" => 57,
  "}" => 1197,
  ">" => 25137
}

total = 0
illegal_characters.each do |char|
  total += @points[char]
end

puts total