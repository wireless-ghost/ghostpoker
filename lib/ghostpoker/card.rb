module Ghostpoker

  class Card

    include Comparable
    extend Factory

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

    REQUIRED_KEYS = %w(suit value)

    attr_reader :suit, :face

    def initialize (card_hash)
      validate(card_hash)
      if VALUES.include?( card_hash["value"] ) && SUITS.include?(card_hash["suit"].upcase)
        @value = card_hash["value"]
        @suit = card_hash["suit"].upcase
      elsif
        puts "THIS CARD IS NOT VALID!"
      end
    end

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

    def to_json
      {"suit" => @suit, "value" => @value}.to_json
    end
  end
end
