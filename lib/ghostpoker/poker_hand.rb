module Ghostpoker

  class PokerHand
    
    extend Factory
    include Comparable

    def initialize(poker_hand_hash = Hash.new)
      @cards = poker_hand_hash["cards"]
      if @cards == nil
        @cards = []
      end
    end

    HANDS = {
      :high_card => 0,
      :one_pair => 1, 
      :two_pair => 2,
      :three_of_a_kind => 3,
      :straight => 4,
      :flush => 5,
      :full_house => 6,
      :four_of_a_kind => 7,
      :straight_flush => 8,
      :royal_flush => 9
    }

    def high_card
      @cards.sort{ |a, b| b.value <=> a.value }[0]
    end

    { pair: 1, three_of_a_kind: 2, four_of_a_kind: 3 }.each do |name, target|
      define_method("#{name}?") do 
        (@cards.size - @cards.uniq{ |card| card.value  }.size) == target
      end
    end

    def straight?
      sort_by_values!
      return true if @cards[0].value - 4 == @cards[4].value
      return true if @cards[1].value - 4 == @cards[5].value
      return true if @cards[2].value - 4 == @cards[6].value
      if ace = @cards.select{ |card| card.value == Card::NUMBER_VALUES['A'] }.first
        return true if @cards[3].value - 4 == 1
      end
      false
    end

    def flush?
      Card::SUITS.chars.to_a.each do |suit|
        return true if (@cards.select{ |card| card.suit == suit }.size > 4)
      end
      false
    end

    def straight_flush?
      straight? && flush?
    end

    def royal_flush?
      straight? && flush? && high_card.value == Card::NUMBER_VALUES['A']
    end

    def sort_by_values!
      @cards.sort!{ |a, b| a.value <=> b.value }.reverse!
    end

    def sort_by_suits!
      @cards.sort!{ |a, b| a.suit <=> b.suit }
    end

    def add_card(card)
      if @cards.length < 7
        @cards<<card
      end
    end
  end
end
