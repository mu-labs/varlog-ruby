require 'socket'
require 'json'
require 'singleton'

module Varlog
  class Collector
    include Singleton

    def initialize
      @socket = UDPSocket.new
      host = ENV['VARLOG_PORT_8015_UDP_ADDR']
      port = ENV['VARLOG_PORT_8015_UDP_PORT']
      @socket.connect(host || 'localhost', port || 8015)
    end

    def collect(event)
      json = event.to_h.to_json
      begin
        @socket.send(json, 0)
      rescue => e
        p e
      end
    end


  end
end
