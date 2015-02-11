module Ghostpoker

  class Client

    def initialize(server)
      @server = server
      @request = nil
      @response = nil
      listen
      send
      @request.join
      @response.join
      @player
    end

    def listen
      @response = Thread.new do
        loop {
          @player = Player.get @server.gets.chomp
          puts "#{msg}"
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
