module Ghostpoker
  class Card
    include Comparable

    SUITS = "CHSD" # Clubs, Hearts, Spades, Diamonds
    VALUES = "23456789TJQKA"
    NUMBER_VALUES = {
      '2' => 2,
      '3' => 3, 
      '4' => 4,
      '5' => 5,
      '6' => 6,
      '7' => 7,
      '8' => 8,
      '9' => 9,
      'T' => 10,
      'J' => 11,
      'Q' => 12,
      'K' => 13,
      'A' => 14
    }

    SUITS_ASCII = {
      'C' => '♣',
      'H' => '♥',
      'S' => '♠',
      'D' => '♦'
    }

    attr_reader :suit, :face

    def value
      NUMBER_VALUES[@value.upcase]
    end

    def value=(new_value)
      @value = new_value.to_s.upcase
    end

    def to_s_ascii
      @value + SUITS_ASCII[@suit]
    end

    def to_s
      @value + @suit
    end

    def <=> another_card
      self.value <=> another_card.value
    end

    def initialize (card_hash)
      if VALUES.include?( card_hash[:value] ) && SUITS.include?(card_hash[:suit].upcase)
        @value = card_hash[:value]
        @suit = card_hash[:suit].upcase
      elsif
        puts "THIS CARD IS NOT VALID!"
      end
    end

    def to_json
      { :card => {:suit => @suit, :value => @value} }.to_json
    end

    def parse_from_json(json_string)
      card = JSON.parse json_string
      if card["card"] != nil
        @suit = card["card"]["suit"]
        @value = card["card"]["face"]
      end
    end
  end
end
