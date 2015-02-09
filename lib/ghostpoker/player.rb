module Ghostpoker

  class Player

    extend Factory

    PLAYER_TURN = {
      :big_blind => 0, 
      :small_blind => 1,
      :button => 2, 
      :regular => 3
    }

    PLAYER_ACTION = {
      :bet => 0,
      :check => 1,
      :raise => 2,
      :fold => 3
    }

    attr_accessor :name, :ip, :turn, :action, :bet
    attr_reader :money, :poker_hand, :id

    def initialize(player_hash)
      @name       = player_hash["name"]
      @ip         = player_hash["ip"]
      @money      = player_hash["money"]
      @poker_hand = player_hash["poker_hand"]
      @id         = player_hash["id"] == nil ? SecureRandom.uuid : player_hash["id"]
      @turn       = player_hash["turn"] unless player_hash["turn"] == nil

      if @poker_hand == nil
        @poker_hand = PokerHand.new
      end
    end

    def can_bet?
      @money > 0
    end

    alias_method :broke?, :can_bet?

    def bet(amount)
      if amount <= money
        @money -= amount
      end
    end

    def won(amount)
      @money += amount
    end

    def recieve_card(card)
      @poker_hand.add_card card
    end

    def add_money(amount)
      @money += amount
    end

    def to_json
      { "name" => @name, "ip" => @ip, "money" => @money, "id" => @id }.to_json 
    end

    def turn
      
    end
  end
end
