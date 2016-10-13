module Udipo
  BROADCAST_ADDR = Socket::IPAddress.new(
    Socket::Family::INET,
    "192.168.0.255", 6667
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
