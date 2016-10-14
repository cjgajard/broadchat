require "socket"

class Broadchat::Connection
  @user_id : String

  def initialize(@address : String, @port : Int32)
    @socket = UDPSocket.new
    @buffer = Bytes.new(512)
    @user_id = "%08X" % object_id
    @socket_address = Socket::IPAddress.new(
      Socket::Family::INET,
      @address, @port,
    )
    @recv_channel = Channel(Nil).new
    @write_channel = Channel(String?).new
  end

  # Wraps all close calls for any connection which needs to close
  def close
    @socket.close
  end

  # Wraps all unsafe configuration needed
  def setup
    @socket.broadcast = true
    @socket.bind(@address, @port)
    self
  end

  # Starts the command-line interface, falling into a loop which prints
  # new broadcasted messages and sends new inputs
  def listen
    puts "Welcome to Broadchat!"
    wait_msg
    wait_input
    loop do
      select
      when @recv_channel.receive
        print "\r> ", String.new(@buffer)
        @buffer.to_unsafe.clear(512)
        wait_msg
      when msg = @write_channel.receive
        @socket.send(msg, @socket_address) if msg
        wait_input
      end
    end
  end

  # Starts waiting asyncronously for a new broadcast message.
  private def wait_msg
    spawn do
      @socket.receive(@buffer)
      @recv_channel.send(nil)
    end
    print "\r: "
  end

  # Starts waiting asyncronously for an user input
  private def wait_input
    spawn do
      msg = gets
      @write_channel.send(msg)
    end
  end
end
