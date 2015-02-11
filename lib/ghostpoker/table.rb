module Ghostpoker

  class Table

    TABLE_STATES = {
      :pre_flop => 0,
      :flop     => 1,
      :turn     => 2,
      :river    => 3,
      :end      => 4
    }

    attr_accessor :deck, :dealed_cards, :pot, :minimum_bet
    attr_reader   :player_id_turn, :players

    def initialize
      @deck = Deck.new Hash.new
      @deck.shuffle
      @dealed_cards = Array.new
      @pot = 0
      @table_state = TABLE_STATES[:pre_flop]
      @players = Array.new
      @playing_players = Array.new
    end

    def turn
      # before every card that is dealed to the table
      # one card should be dealed away
      if @table_state == nil 
        @table_state = TABLE_STATES[:pre_flop]
      end
      case(@table_state)
      when TABLE_STATES[:pre_flop]
        @playing_players.push @players
        2.times do 
          @players.each do |player|
            player.recieve_card(@deck.deal)
          end
        end
        @players.each do |player|
          player.turn
        end
        @table_state = TABLE_STATES[:flop]
      when TABLE_STATES[:end]
        #do nothing   
      else
        deal_card 0
        deal_card
        @table_state += 1
      end
    end

    def loop_players
      @players.each do |player|
        player.turn
        if player.action == Player::PLAYER_ACTION[:bet]
          add_to_pot player.bet
        elsif player.action == Player::PLAYER_ACTION[:fold]
          fold_player player
        elsif player.action == Player::PLAYER_ACTION[:raise]
          add_to_pot player.bet         
        elsif player.action == Player::PLAYER_ACTION[:check]

        end
      end
    end

    def fold_player(player)
      if @playing_players.include? player
        @playing_players.delete player
      end
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

    def add_player(player)
      if @players == nil
        @players = Array.new
      end
      @players.push player
    end
  end
end
