#!/usr/bin/env ruby -w
module Ghostpoker

  class Server

    def initialize(port, ip)
      @server = TCPServer.open(ip, port)
      @connections = Hash.new
      @clients = Hash.new
      @players = Hash.new
      @connections[:clients] = @clients
      @connections[:players] = @players
      @table = Table.new
    end

    def check_for_empty_seats
      @connections[:clients].length > 5
    end

    def run
      loop {
        Thread.start(@server.accept) do |client|
          player = Player.get client.gets
          if !check_for_empty_seats
            client.puts "All seats have been taken! Exiting..."
            Thread.kill self
          end
          @connections[:clients].each do |other_id, other_client|
            if @connections[:players][other_id].name == player.name || other_client == client
              client.puts "This username is already in use! Exiting..."
              Thread.kill self
            end
          end
          @connections[:clients][player.id] = client
          @connections[:players][player.id] = player
          ap "Player #{player.name} has been connected!"
          listen_user_message(player.id, client)
        end
      }.join
    end

    def listen_user_message(username, client)
      loop {
        new_player = Player.get client.gets.chomp
        
        ap new_player.action
        @connections[:clients].each do |other_id, other_client|
          puts @connections[:players][other_id].name
        end
      }
    end
  end
end
