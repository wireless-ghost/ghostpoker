module Ghostpoker

  class Table

    extend Factory

    TABLE_STATES = {
      :pre_flop => 0,
      :flop     => 1,
      :turn     => 2,
      :river    => 3,
      :end      => 4
    }

    attr_accessor :deck, :dealed_cards, :pot, :minimum_bet
    attr_reader   :player_id_turn, :players

    def initialize(deck_hash)
      @deck = Deck.new Hash.new
      @deck.shuffle
      @dealed_cards = Array.new
      @pot = 0
      @table_state = TABLE_STATES[:pre_flop]
      @players = Array.new
      ap "player init #{deck_hash}"
      if deck_hash != nil
        @deck = Deck.get deck_hash["deck"]
        dealed_cards_from_json deck_hash["dealed_cards"]
        @pot = deck_hash["pot"]
        @table_state = deck_hash["table_state"]
        players_from_json deck_hash["players"]
      end
    end

    def turn
      ap "table turn"
      if @table_state == nil 
        @table_state = TABLE_STATES[:pre_flop]
      end
      case(@table_state)
      when TABLE_STATES[:pre_flop]
        ap "pre flop:"
        ap @players.length
        2.times do 
          @players.each do |player|
            ap "dealing cards"
            card = @deck.deal 
            player.recieve_card card
            @dealed_cards << card
          end
        end
        @players.each do |player|
          if player.playing == 1
            player.my_turn = 1
          end
        end
        @table_state = TABLE_STATES[:flop]
        ap "batman"
      when TABLE_STATES[:end]
        #do nothing   
      else
        deal_card 0
        deal_card
        @table_state += 1
      end
      ap "exiting table turn"
    end

    def fold_player(player)
      player.turn = Player::PLAYER_ACTION[:not_playing]
    end
    ap @players

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

    def add_player(player)
      if @players == nil
        @players = Array.new
      end
      @players.push player
    end

    def array_to_json array
      result = Array.new
      if array != nil && array.length > 0
        array.each do |item|
          result << item.to_json
        end
      end
      result
    end

    def dealed_cards_from_json cards
      return if cards == nil
      @dealed_cards = Array.new
      cards.each do |card_json|
        card = Card.get card_json
        @dealed_cards << card
      end
    end

    def players_from_json players
      return if players == nil
      @players = Array.new
      players.each do |player_json|
        player = Player.get player_json
        @players << player
      end
    end

    def to_json
      { 
        "deck"            => @deck.to_json, 
        "players"          => array_to_json( @players ), 
        "pot"             => @pot, 
        "dealed_cards"    => array_to_json( @dealed_cards ), 
        "table_state"     => @table_state, 
      }.to_json
    end
  end
end
