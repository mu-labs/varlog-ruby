require 'securerandom'

module Varlog
  class HTTPRequestEvent

    def initialize(span, timestamp, method, endpoint)
      @span = span
      @timestamp = timestamp
      @method = method
      @endpoint = endpoint
      @schema = 'HTTPRequest'
    end

    def to_h
      {
          timestamp: @timestamp,
          method: @method,
          endpoint: @endpoint,
          schema: @schema
      }.merge(@span)
    end

  end

  class HTTPResponseEvent

    def initialize(span, timestamp, status, endpoint, rtt)
      @span = span
      @timestamp = timestamp
      @status = status
      @endpoint = endpoint
      @rtt = rtt
      @schema = 'HTTPResponse'
    end

    def to_h
      {
          timestamp: @timestamp,
          status: @status,
          method: @method,
          endpoint: @endpoint,
          rtt: @rtt,
          schema: @schema
      }.merge(@span)
    end

  end

  class LogEvent

    def initialize(span, timestamp, log, severity)
      @span = span
      @timestamp = timestamp
      @severity = severity
      @message = log
      @schema = 'Log'
    end

    def to_h
        {
            timestamp: @timestamp,
            severity: @severity,
            message: @message,
            schema: @schema
        }.merge(@span)
    end

  end

end
