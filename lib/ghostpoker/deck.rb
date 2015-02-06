module Ghostpoker
  class Deck
    def initialize
      @cards = []
      Card::SUITS.each_byte do |suit|
        Card::FACES.each_byte do |face|
          @cards.push(Card.new(suit.chr, face.chr))
        end
      end
      shuffle
    end

    def shuffle
      @cards = @cards.sort_by { rand }
      return self
    end

    def deal
      @cards.pop
    end

    def size
      @cards.size
    end

    def empty?
      @cards.empty?
    end
  end
end
