module Ghostpoker

  class Game

    def initialize

    end

    def console_mode
      table = Table.new
      console = ConsoleMode.new({ "table" => table })

      console.start_game
      console.turn
      #console.player.recieve_card Card.new({ "value" => '9', "suit" => "d" })
      #console.print_table
      #console.print_table
    end

    def start
      c1 = Card.new({ "value" => 'J', "suit" => 'c' })
      c2 = Card.new({ "value" => 'K', "suit" => 'c' })
      c3 = Card.new({ "value" => 'Q', "suit" => 'c' })
      c4 = Card.new({ "value" => 'T', "suit" => 'c' })
      c5 = Card.new({ "value" => 'A', "suit" => 'c' })
      c6 = Card.new({ "value" => '9', "suit" => 'c' })
      c7 = Card.new({ "value" => '8', "suit" => 'c' })
      ap "Card c1 has value #{c1.value} and it is represented as #{c1.to_s}"
      ap "Card c2 has value #{c2.value} and it is represented as #{c2.to_s}"

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

      hand = PokerHand.new({ "cards" => han })
      ap hand.high_card.to_s
      ap hand.straight_flush?
      ap hand.straight?
      ap hand.flush?
      ap hand.royal_flush?
      ap hand.pair?
      ap hand.three_of_a_kind?
      ap c5.to_json
      
      #c8 = Card.parse_from_json c5.to_json
      #ap c8.to_s5
      ap 'batman'
      player = Player.new({ "name" => 'Mad Max', "ip" => "127.0.0.1", "money" => 50 })
      #player.recieve_card c1
      #player.recieve_card c2
      #player.recieve_card c3
      #player.recieve_card c4

      ap player.can_bet?
      player.bet(20)
      ap player.broke?
      ap player.name

      ap "player id: #{player.id}"
      
      card_with_get = Card.get(c5.to_json)
      ap card_with_get.to_s

      #table = Table.new
    end
  end
end
