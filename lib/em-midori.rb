require 'eventmachine'
require 'fiber'

module Midori
  def self.run(api=(Midori::API), ip=nil, port=nil)
    ip ||= '127.0.0.1'
    port ||= 8081
    EventMachine.run {
      route = api.new
      puts "Midori Server Running on #{ip} at #{port}"
      EventMachine.start_server ip, port, Midori::Server
    }
  end
end

module Midori::Server
  def receive_data(data)
    port, ip = Socket.unpack_sockaddr_in(get_peername)
    puts "from #{ip}:#{port} comes a message:"
    #puts data
    send_data 'Hello World'
    close_connection_after_writing
  end
end

class Midori::API
  #TODO: Move to API part
  # def self.get(route)
  #   yield
  # end
  #
  def self.post(route)
    yield
  end
  #
  # def self.put(route)
  #   yield
  # end
  #
  # def self.delete(route)
  #   yield
  # end
  #
  # def self.options(route)
  #   yield
  # end
  #
  # def self.link(route)
  #   yield
  # end
  #
  # def self.unlink(route)
  #   yield
  # end
end

# Midori.run(Midori::API, '0.0.0.0', 8080)