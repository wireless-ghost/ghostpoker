module Ghostpoker

  class Deck

    extend Factory

    def initialize(deck_hash)
      @cards = deck_hash["cards"]
      if @card == nil || @cards.lenght = 0
        @cards = []
        Card::SUITS.chars.each do |suit|
          Card::VALUES.chars.each do |face|
            @cards.push(Card.new({"suit" => suit, "value" =>face}))
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
