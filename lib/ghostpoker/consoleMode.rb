module Ghostpoker

  class ConsoleMode

    attr_accessor :player, :table
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

      @table.add_player @player
    end

    def wait_for_action
      puts "Possible actions:"
      puts "1. Bet (max: #{@player.money})"
      puts "2. Check"
      puts "3. Fold"
      puts
      puts "Please, enter the number of the selected action :"

      selected_action = STDIN.gets.chomp
      selected_action
    end

    def print_cards(cards)
      cards.each do |card|
        print "|#{card.to_s_ascii}| "
      end
      puts
    end

    def print_other_players
      @table.players.each do |player|
        if player != @player
          puts "Player #{player.name} has cards: "
          print_cards player.poker_hand.cards
          puts "and money: #{player.money}"
          puts
        end
      end
    end

    def print_table
      if @table != nil
        puts "The dealed cards are: "
        print_cards @table.dealed_cards
      end

      print_other_players

      puts "Your cards are: "
      print_cards @player.poker_hand.cards

      puts

      if @player.my_turn == 1
        action = wait_for_action
        if action.to_i == 1
          amount = bet_amount
          puts amount
        end
      end
    end

    def turn
      @table.turn
      print_table
    end
  end
end
