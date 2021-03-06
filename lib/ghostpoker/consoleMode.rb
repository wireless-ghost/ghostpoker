module Ghostpoker

  class ConsoleMode

    attr_accessor
    def initialize
      ap "batman"
    end

    def bet_amount
      puts "Enter the amount you want to bet: "
      amount = STDIN.gets.chomp
      amount.to_i
    end

    def init_player
      ap "init player"
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

      player_hash
    end

    def wait_for_action
      puts "Possible actions:"
      puts "1. Bet"
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

    def print_other_players( table, current_player)
      table.players.each do |player|
        if player != current_player
          puts "Player #{player.name} has cards: "
          print_cards player.poker_hand.cards
          puts "and money: #{player.money}"
          puts
        end
      end
    end

    def print_table( table, current_player )
      if table != nil
        puts "The dealed cards are: "
        print_cards table.dealed_cards
      end

      print_other_players

      puts "Your cards are: "
      print_cards current_player.poker_hand.cards

      puts

      if current_player.my_turn == 1
        action = wait_for_action
        if action.to_i == 1
          amount = bet_amount
          puts amount
        end
      end
    end

  end
end
