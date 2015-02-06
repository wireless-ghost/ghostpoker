module Ghostpoker

  class Game

    def initialize

    end

    def start
      c1 = Card.new('s', 'J')
      c2 = Card.new('s', 'K')
      c3 = Card.new('c', 'Q')
      c4 = Card.new('s', 'T')
      c5 = Card.new('s', 'A')
      c6 = Card.new('c', 'A')
      c7 = Card.new('h', 'A')

      #ap "Card c1 has value #{c1.value} and it is represented as #{c1.to_s}"
      #ap "Card c2 has value #{c2.value} and it is represented as #{c2.to_s}"

      #dec = Deck.new
      #while (!dec.empty?)
      #  ap dec.deal.to_s
      #end

      han = []
      han << c1
      han << c2
      han << c3
      han << c4
      han << c5
      han << c6
      han << c7

      hand = Poker_Hand.new(han)
      ap hand.high_card
      ap hand.straight_flush?
      ap hand.straight?
      ap hand.flush?
      ap hand.royal_flush?
      ap hand.pair?
      ap hand.three_of_a_kind?
      ap c5.to_json
      #player = Player.new("name", "192", 20)
      #player.recieve_card c1
      #player.recieve_card c2
      #player.recieve_card c3
      #player.recieve_card c4

      #p player.can_bet?
      #player.bet(20)
      #p player.broke?

      table = Table.new
    end
  end
end
