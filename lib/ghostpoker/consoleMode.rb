module Ghostpoker

  class ConsoleMode

    attr_accessor :player
    def initialize(state_hash)
      @table = state_hash["table"]
      @player = state_hash["player"]
    end

    def bet_amount
      puts "Enter the amount you want to bet: "
      amount = STDIN.gets.chomp
      amount.to_i
    end

    def start_game
      player_hash = Hash.new

      puts "Please, enter username: "
      name = STDIN.gets.chomp

      puts "Please, enter money: "
      money = STDIN.gets.chomp

      puts "Please, enter ip: "
      ip = STDIN.gets.chomp

      player_hash["name"]  = name
      player_hash["money"] = money
      player_hash["ip"]    = ip

      @player = Player.new player_hash
    end

    def wait_for_action
      puts "Possible actions:"
      puts "1. Bet"
      puts "2. Check"
      puts "3. Fold"
      puts
      puts "Please, enter the number of the selected action :"

      selected_action = STDIN.gets.chomp
    end

    def print_cards(cards)
      cards.each do |card|
        print "|#{card.to_s_ascii}| "
      end
      puts
    end

    def print_table
      if @table != nil
        puts "The dealed cards are: "
        print_cards @table.dealed_cards
      end

      puts "Your cards are: "
      print_cards @player.poker_hand.cards

      action = wait_for_action
      if action == 1
        amount = bet_amount
        puts amount
      end
    end

    def turn
    end
  end
end
