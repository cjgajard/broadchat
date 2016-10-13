require "socket"

module Broadchat
  BROADCAST_ADDR = Socket::IPAddress.new(
    Socket::Family::INET,
    "192.168.1.255", 6667
  )
end

struct Socket::IPAddress
  def inspect(io)
    to_s(io)
  end

  def to_s(io)
    io << @family << '@' << @address << ':' << @port
  end
end
