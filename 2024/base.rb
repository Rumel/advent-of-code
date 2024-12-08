# frozen_string_literal: true

require 'pry'
require 'benchmark'

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

class Base
  def day
    raise 'You must define a day'
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

  def deep_dup(obj)
    Marshal.load(Marshal.dump(obj))
  end
end
