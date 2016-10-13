require "socket"
require "./udipo/common"

class Udipo::Client
  def initialize
    @broadcast_socket = UDPSocket.new
    @client_socket = UDPSocket.new
    @buffer = Bytes.new(512)
  end

  def setup
    @broadcast_socket.broadcast = true
    @broadcast_socket.bind(BROADCAST_ADDR.address, BROADCAST_ADDR.port )
    @client_socket.connect("127.0.0.1", 8080)
    self
  end

  def run
    puts "Welcome to Udipo Broadcast!"
    @client_socket.send("Hello! from #{@client_socket.local_address}")
    loop do
      length, addr = @broadcast_socket.receive(@buffer)
      puts String.new(@buffer), "#{addr}", nil
      @buffer.to_unsafe.clear(512)
    end
  end
end
