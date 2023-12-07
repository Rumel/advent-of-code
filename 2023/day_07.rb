require_relative './base'

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
    FULL_OF_HOUSE
    THREE_OF_A_KIND
    TWO_PAIR
    ONE_PAIR
    HIGH_CARD
  ].freeze

  HAND_TYPE_ORDER = HAND_TYPES.zip((1..HAND_TYPES.length).to_a.reverse).to_h.freeze

  def initialize(cards, bid)
    self.cards = cards.split('')
    self.bid = bid

    uniq = self.cards.uniq
    uniq_count = uniq.length
    uniq = uniq.sort do |a, b|
      result = self.cards.count(b) <=> self.cards.count(a)
      if result == 0
        rank_of_card(b) <=> rank_of_card(a)
      else
        result
      end
    end

    self.card_order = uniq.map { |c| rank_of_card(c) }

    self.hand_type = if uniq_count == 1
                       :FIVE_OF_A_KIND
                     elsif uniq_count == 2
                       if self.cards.count(uniq.first) == 4
                         :FOUR_OF_A_KIND
                       else
                         :FULL_OF_HOUSE
                       end
                     elsif uniq_count == 3
                       if self.cards.count(uniq.first) == 3
                         :THREE_OF_A_KIND
                       else
                         :TWO_PAIR
                       end
                     elsif uniq_count == 4
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
    if result == 0
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

class DumbPokerHand < PokerHand
  def <=>(other)
    result = other.hand_type_rank <=> hand_type_rank
    if result == 0
      cards.each_with_index do |card, index|
        card_result = rank_of_card(other.cards[index]) <=> rank_of_card(card)
        return card_result if card_result != 0
      end
    end

    result
  end
end

class Day07 < Base
  def day
    '07'
  end

  def parse_input(input, klass)
    poker_hands = input.split("\n").map do |line|
      split = line.split(' ')
      klass.new(split[0], split[1].to_i)
    end
  end

  def part1(input)
    poker_hands = parse_input(input, DumbPokerHand)
    sorted = poker_hands.sort
    # sorted.each do |s|
    #   puts s
    # end
    zipped = (1..sorted.length).to_a.reverse.zip(sorted)
    zipped.map { |z| z[0] * z[1].bid }.sum
  end

  def part2(input); end
end

day = Day07.new
puts "Example: #{day.part1(day.example_input_a)}"
puts "Part 1: #{day.part1(day.input)}"
