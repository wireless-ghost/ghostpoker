#!/usr/bin/env ruby -w
module Ghostpoker
  class Server
    def initialize(port, ip)
      @server = TCPServer.open(ip, port)
      @connections = Hash.new
      @clients = Hash.new
      @players = Hash.new
      @connections[:server]  = @server
      @connections[:clients] = @clients
      @connections[:players] = @players
      $mutex = Mutex.new
    end

    def run
      loop {
        Thread.start(@server.accept) do |client|
          player = Player.get client.gets
          $mutex.lock
          @connections[:client].each do |other_name, other_client|
            if other_name == player.name || other_client == client
              client.puts "This username is already in use"
              Thread.kill self
            end
          end
          $mutex.unlock
          @connections[:clients][player.name] = client
          @connections[:players][player.name] = player
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
