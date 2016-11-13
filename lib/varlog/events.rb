require 'securerandom'

module Varlog
  class HTTPRequestEvent

    def initialize(parent_id, timestamp, method, endpoint)
      @id = SecureRandom.uuid()
      @parent_id = parent_id
      @timestamp = timestamp
      @endpoint = endpoint
      @schema = "HTTPRequest"
    end

  end

  class HTTPResponseEvent

    def initialize(parent_id, timestamp, status, endpoint, rtt)
      @id = SecureRandom.uuid()
      @parent_id = parent_id
      @timestamp = timestamp
      @endpoint = endpoint
      @rtt = rtt
      @schema = "HTTPResponse"
    end

  end

  class MessageEvent

    def initialize(parent_id, timestamp, message)
      @id = SecureRandom.uuid()
      @timestamp = timestamp
      @message = message
      @schema = "Message"
    end

  end

end
