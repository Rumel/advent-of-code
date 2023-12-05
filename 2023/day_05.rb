require_relative './base'

class Day05 < Base
  def day
    '05'
  end

  def parse_input(input)
    seeds = []
    seed_to_soil = []
    soil_to_fertilizer = []
    fertilizer_to_water = []
    water_to_light = []
    light_to_temperature = []
    temperature_to_humidity = []
    humidity_to_location = []

    component = nil
    input.split("\n").each do |line|
      if line.start_with?('seeds')
        component = :seeds
      elsif line.start_with?('seed-to-soil')
        component = :seed_to_soil
        next
      elsif line.start_with?('soil-to-fertilizer')
        component = :soil_to_fertilizer
        next
      elsif line.start_with?('fertilizer-to-water')
        component = :fertilizer_to_water
        next
      elsif line.start_with?('water-to-light')
        component = :water_to_light
        next
      elsif line.start_with?('light-to-temperature')
        component = :light_to_temperature
        next
      elsif line.start_with?('temperature-to-humidity')
        component = :temperature_to_humidity
        next
      elsif line.start_with?('humidity-to-location')
        component = :humidity_to_location
        next
      elsif line.strip == ''
        component = nil
        next
      end

      if component == :seeds
        seeds = line.split(':')[1].split(' ').map(&:strip).map(&:to_i)
      elsif component == :seed_to_soil
        seed_to_soil << get_range(line)
      elsif component == :soil_to_fertilizer
        soil_to_fertilizer << get_range(line)
      elsif component == :fertilizer_to_water
        fertilizer_to_water << get_range(line)
      elsif component == :water_to_light
        water_to_light << get_range(line)
      elsif component == :light_to_temperature
        light_to_temperature << get_range(line)
      elsif component == :temperature_to_humidity
        temperature_to_humidity << get_range(line)
      elsif component == :humidity_to_location
        humidity_to_location << get_range(line)
      end
    end

    { seeds:, seed_to_soil:, soil_to_fertilizer:, fertilizer_to_water:, water_to_light:, light_to_temperature:,
      temperature_to_humidity:, humidity_to_location: }
  end

  def part1(input)
    data = parse_input(input)

    seed_locations = get_seed_location(data)
    seed_locations.map { |x| x[:location] }.min
  end

  def part2(input); end

  private

  def get_range(line)
    split = line.split(' ')
    length = split[2].to_i
    destination = (split[0].to_i)..(split[0].to_i + length - 1)
    source = (split[1].to_i)..(split[1].to_i + length - 1)

    { source:, destination:, length: }
  end

  def get_seed_location(data)
    result = []
    data[:seeds].each do |seed|
      soil = get_value(data[:seed_to_soil], seed)
      fertilizer = get_value(data[:soil_to_fertilizer], soil)
      water = get_value(data[:fertilizer_to_water], fertilizer)
      light = get_value(data[:water_to_light], water)
      temperature = get_value(data[:light_to_temperature], light)
      humidity = get_value(data[:temperature_to_humidity], temperature)
      location = get_value(data[:humidity_to_location], humidity)

      result << { seed:, soil:, fertilizer:, water:, light:, temperature:, humidity:, location: }
    end
    result
  end

  def get_value(ranges, num)
    ranges.each do |range|
      return num - range[:source].first + range[:destination].first if range[:source].include?(num)
    end

    num
  end
end

day = Day05.new
puts "Example: #{day.part1(day.example_input_a)}"
puts "Part 1: #{day.part1(day.input)}"
