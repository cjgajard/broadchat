require "socket"
require "./broadchat/common"

class Broadchat::Server
  SERVER_ADDR = Socket::IPAddress.new(
    Socket::Family::INET,
    "127.0.0.1", 8080
  )

  def initialize
    @recv_socket = UDPSocket.new
    @broadcast_socket = UDPSocket.new
    @buffer = Bytes.new(512)
  end

  def setup
    @broadcast_socket.broadcast = true
    @broadcast_socket.bind(BROADCAST_ADDR.address, BROADCAST_ADDR.port)
    @recv_socket.bind(SERVER_ADDR.address, SERVER_ADDR.port)
    self
  end

  def listen
    puts "Listening to #{@recv_socket.local_address} ..." # TODO Use remote_address
    loop do
      length, addr = @recv_socket.receive(@buffer)
      if addr != SERVER_ADDR && addr != BROADCAST_ADDR
        @broadcast_socket.send(@buffer, BROADCAST_ADDR)
        puts addr, String.new(@buffer), nil # DEBUG
      end
      @buffer.to_unsafe.clear(512)
    end
  end
end
