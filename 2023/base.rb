require 'pry'

class Base
  def day
    raise "You must define a day"
  end

  def example_input_a
    @example_input_a ||= File.read(File.join(__dir__, "data/#{day}_example_a.txt"))
  end

  def example_input_b
    @example_input_b ||= File.read(File.join(__dir__, "data/#{day}_example_b.txt"))
  end

  def input
    @input ||= File.read(File.join(__dir__, "data/#{day}_input.txt"))
  end
end