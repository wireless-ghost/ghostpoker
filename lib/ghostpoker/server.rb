#!/usr/bin/env ruby -w
module Ghostpoker
  class Server
    def initialize(port, ip)
      @server = TCPServer.open(ip, port)
      @connections = Hash.new
      @clients = Hash.new
      @connections[:server] = @server
      @connections[:clients] = @clients
    end

    def run
      loop {
        Thread.start(@server.accept) do |client|
          player = Player.get client.gets
          ap player.name
          ap player.money
          @connections[:clients][player.money] = client
          client.puts "Connection established, Thank you for joining! Happy Chatting!"
          #listen_user_message(nick_name, client)
        end
      }.join
    end

    def listen_user_message(username, client)
      #loop {
      #  msg = client.gets.chomp
      #  @connections[:clients].each do |other_name, other_client|
      #    unless other_name == username
      #      other_client.puts "#{username.to_s}: #{msg}"
      #    end
      #  end
      #}
    end
  end
end
