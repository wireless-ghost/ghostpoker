module Ghostpoker

  class Table

    TABLE_STATES = {
      :pre_flop => 0,
      :flop     => 1,
      :turn     => 2,
      :river    => 3
    }

    attr_accessor :deck, :dealed_cards, :pot, :minimum_bet

    def initialize
      @deck = Deck.new
      @deck.shuffle
      @dealed_cards = Array.new
      @pot = 0
      @table_state = TABLE_STATES[:pre_flop]
      @players = Array.new
      @players.each  do |player|
        player.recieve_card(@deck.deal_card)
        player.recieve_card(@deck.deal_card)
      end
    end

    def turn
      # before every card that is dealed to the table
      # one card should be dealed away
      deal_card 0
      deal_card
    end

    def deal_card(add_to_dealed_cards = 1)
      if !@deck.empty?
        @dealed_cards << @deck.deal unless add_to_dealed_cards == 0
        @dealed_cards.last
      end
    end

    def add_to_pot(amount)
      @pot += amount
    end

    def clear
      @pot = 0
      @dealed_cards = Array.new
    end
  end
end
