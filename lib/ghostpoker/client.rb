module Ghostpoker

  class Client

    attr_accessor :table, :player

    def initialize(server, player)
      @server = server
      @request = nil
      @response = nil
      @console = ConsoleMode.new
      start_game
      send
      listen
      @request.join
      @response.join
    end

    def start_game
      @table = Table.get @server.gets.chomp
      @player = Player.get @console.init_player
      ap @player.id
    end

    def turn
      ap "in turn"
      player = @table.players.select { |player| player.id == @player.id }[0]
      @player = player
      ap "turn over"
      if @player.my_turn == 1
        ap "printing"
        @console.print_table @table, @player
        @player.action = @console.wait_for_action
        case @player.action
        when Player::PLAYER_ACTION[:bet]
          bet = @console.bet_amount
          @player.bet bet
          @table.add_to_pot bet
        when Player::PLAYER_ACTION[:fold]
          @player.fold
        when Player::PLAYER_ACTION[:check]
          @player.check
        end
      end
    end

    def listen
      @response = Thread.new do
        loop {
          ap "listen"
          while (hash = @server.gets) == nil
            ap "nothing"
          end
          @table = Table.get hash
          turn
        }
      end
    end

    def send
      @request = Thread.new do
        loop {
          msg = @player.to_json
          @server.puts( msg )
        }
      end
    end
  end
end
