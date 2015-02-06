module Ghostpoker
  class Card
    include Comparable

    SUITS = "CHSD" # Clubs, Hearts, Spades, Diamonds
    FACES = "23456789TJQKA"
    FACE_VALUES = {
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
      FACE_VALUES[@face.upcase]
    end

    def value=(new_value)
      @face = new_value.to_s.upcase
    end

    def to_s_ascii
      @face + SUITS_ASCII[@suit]
    end

    def to_s
      @face + @suit
    end

    def <=> another_card
      self.value <=> another_card.value
    end

    def initialize (suit, face)
      if face.length == 1 && FACES.include?( face ) && face.length == 1 && SUITS.include?(suit.upcase)
        @face = face
        @suit = suit.upcase
      elsif
        puts "THIS CARD IS NOT VALID!"
      end
    end

    def to_json
      {:card => (@face + @suit)}.to_json
    end
  end
end
