require 'securerandom'

module Varlog
  class HTTPRequestEvent

    def initialize(parent_id, timestamp, method, endpoint)
      self.id = SecureRandom.uuid()
      self.parent_id = parent_id
      self.timestamp = timestamp
      self.endpoint = endpoint
      self.type = type
      self.schema = "HTTPRequest"
    end

  end

  class HTTPResponseEvent

    def initialize(parent_id, timestamp, status, endpoint, rtt)
      self.id = SecureRandom.uuid()
      self.parent_id = parent_id
      self.timestamp = timestamp
      self.endpoint = endpoint
      self.type = type
      self.rtt = rtt
      self.schema = "HTTPResponse"
    end

  end

  class MessageEvent

    def initialize(parent_id, timestamp, message)
      self.id = SecureRandom.uuid()
      self.timestamp = timestamp
      self.endpoint = endpoint
      self.message = message
      self.schema = "Message"
    end

  end

end
