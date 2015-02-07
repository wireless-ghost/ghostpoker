module Ghostpoker

  class Client

    def initialize(server, name)
      @server = server
      @request = nil
      @response = nil
      @name = name
      listen
      send
      @request.join
      @response.join
    end

    def listen
      @response = Thread.new do
        loop {
          msg = @server.gets.chomp
          puts "#{msg}"
        }
      end
    end

    def send
      @request = Thread.new do
        loop {
          player = Player.new({ "name" => @name, "ip" => "1234", "money" => 5000 })
          msg = player.to_json
          @server.puts( msg )
        }
      end
    end
  end
end
