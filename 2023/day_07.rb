# frozen_string_literal: true

require_relative 'base'

class PokerHand
  attr_accessor :cards,
                :hand_type,
                :card_order,
                :bid,
                :hand_type_rank

  CARD_RANKS = [
    ['A', 14],
    ['K', 13],
    ['Q', 12],
    ['J', 11],
    ['T', 10],
    ['9', 9],
    ['8', 8],
    ['7', 7],
    ['6', 6],
    ['5', 5],
    ['4', 4],
    ['3', 3],
    ['2', 2]
  ].to_h.freeze

  HAND_TYPES = %i[
    FIVE_OF_A_KIND
    FOUR_OF_A_KIND
    FULL_HOUSE
    THREE_OF_A_KIND
    TWO_PAIR
    ONE_PAIR
    HIGH_CARD
  ].freeze

  HAND_TYPE_ORDER = HAND_TYPES.zip((1..HAND_TYPES.length).to_a.reverse).to_h.freeze

  def initialize(cards, bid)
    self.cards = cards.chars
    self.bid = bid

    uniq = self.cards.uniq
    uniq_count = uniq.length
    uniq = uniq.sort do |a, b|
      result = self.cards.count(b) <=> self.cards.count(a)
      if result.zero?
        rank_of_card(b) <=> rank_of_card(a)
      else
        result
      end
    end

    self.card_order = uniq.map { |c| rank_of_card(c) }

    self.hand_type = case uniq_count
                     when 1
                       :FIVE_OF_A_KIND
                     when 2
                       if self.cards.count(uniq.first) == 4
                         :FOUR_OF_A_KIND
                       else
                         :FULL_HOUSE
                       end
                     when 3
                       if self.cards.count(uniq.first) == 3
                         :THREE_OF_A_KIND
                       else
                         :TWO_PAIR
                       end
                     when 4
                       :ONE_PAIR
                     else
                       :HIGH_CARD
                     end

    self.hand_type_rank = rank_of_hand(hand_type)
  end

  def inspect
    "#{cards.inspect} #{bid.inspect} #{hand_type} #{hand_type_rank} #{card_order.inspect}}"
  end

  def to_s
    inspect
  end

  def <=>(other)
    result = other.hand_type_rank <=> hand_type_rank
    if result.zero?
      card_order.each_with_index do |card, index|
        card_result = other.card_order[index] <=> card
        return card_result if card_result != 0
      end
    end

    result
  end

  private

  def rank_of_card(card)
    CARD_RANKS[card]
  end

  def rank_of_hand(hand_type)
    HAND_TYPE_ORDER[hand_type]
  end
end

class JokerPokerHand
  attr_accessor :cards,
                :hand_type,
                :card_order,
                :bid,
                :hand_type_rank

  CARD_RANKS = [
    ['A', 14],
    ['K', 13],
    ['Q', 12],
    ['T', 11],
    ['9', 10],
    ['8', 9],
    ['7', 8],
    ['6', 7],
    ['5', 6],
    ['4', 5],
    ['3', 4],
    ['2', 3],
    ['J', 2]
  ].to_h.freeze

  HAND_TYPES = %i[
    FIVE_OF_A_KIND
    FOUR_OF_A_KIND
    FULL_HOUSE
    THREE_OF_A_KIND
    TWO_PAIR
    ONE_PAIR
    HIGH_CARD
  ].freeze

  HAND_TYPE_ORDER = HAND_TYPES.zip((1..HAND_TYPES.length).to_a.reverse).to_h.freeze

  def initialize(cards, bid)
    self.cards = cards.chars
    self.bid = bid

    uniq = self.cards.uniq.reject { |c| c == 'J' }
    uniq = uniq.sort do |a, b|
      self.cards.count(b) <=> self.cards.count(a)
    end

    count = uniq.map { |c| self.cards.count(c) }

    self.card_order = self.cards.map { |c| rank_of_card(c) }

    self.hand_type = case count[0]
                     when 5
                       :FIVE_OF_A_KIND
                     when 4
                       :FOUR_OF_A_KIND
                     when 3
                       if count[1] == 2
                         :FULL_HOUSE
                       else
                         :THREE_OF_A_KIND
                       end
                     when 2
                       if count[1] == 2
                         :TWO_PAIR
                       else
                         :ONE_PAIR
                       end
                     else
                       :HIGH_CARD
                     end

    num_jokers = self.cards.count('J')
    num_jokers.times.each do
      case hand_type
      when :FOUR_OF_A_KIND
        self.hand_type = :FIVE_OF_A_KIND
      when :THREE_OF_A_KIND
        self.hand_type = :FOUR_OF_A_KIND
      when :TWO_PAIR
        self.hand_type = :FULL_HOUSE
      when :ONE_PAIR
        self.hand_type = :THREE_OF_A_KIND
      when :HIGH_CARD
        self.hand_type = :ONE_PAIR
      end
    end

    self.hand_type_rank = rank_of_hand(hand_type)
  end

  def inspect
    "#{cards.inspect} #{bid.inspect} #{hand_type} #{hand_type_rank} #{card_order.inspect}}"
  end

  def to_s
    inspect
  end

  def <=>(other)
    result = other.hand_type_rank <=> hand_type_rank
    if result.zero?
      cards.each_with_index do |card, index|
        card_result = rank_of_card(other.cards[index]) <=> rank_of_card(card)
        return card_result if card_result != 0
      end
    end

    result
  end

  private

  def rank_of_card(card)
    CARD_RANKS[card]
  end

  def rank_of_hand(hand_type)
    HAND_TYPE_ORDER[hand_type]
  end
end

class Day07 < Base
  def day
    '07'
  end

  def parse_input(input, klass)
    input.split("\n").map do |line|
      split = line.split
      klass.new(split[0], split[1].to_i)
    end
  end

  def part1(input)
    poker_hands = parse_input(input, PokerHand)
    sorted = poker_hands.sort
    zipped = (1..sorted.length).to_a.reverse.zip(sorted)
    zipped.map { |z| z[0] * z[1].bid }.sum
  end

  def part2(input)
    poker_hands = parse_input(input, JokerPokerHand)
    sorted = poker_hands.sort
    zipped = (1..sorted.length).to_a.reverse.zip(sorted)
    zipped.map { |z| z[0] * z[1].bid }.sum
  end
end

day = Day07.new
puts "Example: #{day.part1(day.example_input_a)}"
puts "Part 1: #{day.part1(day.input)}"
puts "Example: #{day.part2(day.example_input_a)}"
puts "Part 2: #{day.part2(day.input)}"
