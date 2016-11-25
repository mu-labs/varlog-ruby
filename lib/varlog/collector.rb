require 'socket'
require 'json'
require 'singleton'

module Varlog
  class Collector
    include Singleton

    def initialize
      @socket = UDPSocket.new
      @socket.connect('localhost', 8015)
    end

    def collect(event)
      json = event.to_h.to_json
      p json
      begin
        @socket.send(json, 0)
      rescue => e
        p e
      end
    end


  end
end
