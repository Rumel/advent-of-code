lines = File.readlines('sample.txt')

@mapping = {
  "0" => "0000",
  "1" => "0001",
  "2" => "0010",
  "3" => "0011",
  "4" => "0100",
  "5" => "0101",
  "6" => "0110",
  "7" => "0111",
  "8" => "1000",
  "9" => "1001",
  "A" => "1010",
  "B" => "1011",
  "C" => "1100",
  "D" => "1101",
  "E" => "1110",
  "F" => "1111"
}

def get_binary(s)
  new_s = ""

  s.chars.each do |c|
    new_s += @mapping[c]
  end

  new_s
end

def get_binary_number(s)
  case s
  when "000"
    return 0
  when "001"
    return 1
  when "010"
    return 2
  when "011"
    return 3
  when "100"
    return 4
  when "101"
    return 5
  when "110"
    return 6
  when "111"
    return 7
  end

  nil
end

def is_total_length?(s)
  s == '0'
end

def get_header(s, i = 0)
  version_slice = s.slice(i, 3)
  type_slice = s.slice(i + 3, 3)

  { :version => get_binary_number(version_slice), :type => get_binary_number(type_slice) }
end

packets = []
class Packet
  attr_accessor :version, :type_id

  def initialize
  end

  def is_literal?
    @type_id == 4
  end
end

lines.each do |line|
  packets = []
  
  b = get_binary(line.chomp)

  puts "#{line.chomp} => #{b}"
  i = 0
  while i < b.length
    headers = get_header(b, i)
    puts "Version: #{headers[:version]}"
    puts "Type: #{headers[:type]}"
    p = Packet.new
    p.version = headers[:version]
    p.type_id = headers[:type]

    if p.is_literal?
      
    end

    i = b.length
  end
end