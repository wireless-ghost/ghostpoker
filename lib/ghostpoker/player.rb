module Ghostpoker

  class Player

    extend Factory

    attr_accessor :name, :ip
    attr_reader :money, :poker_hand, :id

    def initialize(player_hash)
      @name       = player_hash["name"]
      @ip         = player_hash["ip"]
      @money      = player_hash["money"]
      @poker_hand = player_hash["poker_hand"]
      @id         = player_hash["id"] == nil ? SecureRandom.uuid : player_hash["id"]

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
  end
end
