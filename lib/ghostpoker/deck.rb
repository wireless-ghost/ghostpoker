module Ghostpoker

  class Deck

    extend Factory

    def initialize(deck_hash)
      @cards = deck_hash["cards"]
      if @cards.length = 0
        Card::SUITS.each_byte do |suit|
          Card::VALUES.each_byte do |face|
            @cards.push(Card.new(suit.chr, face.chr))
          end
        end
        shuffle
      end
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
