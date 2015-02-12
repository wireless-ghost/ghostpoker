module Ghostpoker

  class Deck

    extend Factory

    def initialize(deck_hash)
      if deck_hash != nil && deck_hash.size > 0
        @cards = cards_from_json deck_hash["cards"]
      end
      if @cards == nil || @cards.size == 0
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

    def cards_to_json
      result = Array.new
      if @cards != nil && @cards.length > 0
        c = 0
        @cards.each do |card|
          result << card.to_json
          c += 1
        end
      end
      result
    end

    def cards_from_json cards_json
      @cards = Array.new
      cards = JSON.parse cards_json.to_s
      cards.to_a.each do |a|
        card = Card.get a
        @cards << card
      end
    end

    def to_json
      { "cards" => cards_to_json }.to_json
    end
  end
end
