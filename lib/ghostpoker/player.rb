module Ghostpoker
  class Player
    attr_accessor :name, :ip
    attr_reader :money, :poker_hand

    def initialize(name, ip, money)
      @name, @ip, @money = name, ip, money
      @poker_hand = Poker_Hand.new
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
  end
end
