require 'logger'
require 'json'

module Varlog
  class Logger
    def self.new
      writer = Varlog::LogWriter.new
      logger = ::Logger.new(writer)
      logger.formatter = writer.formatter

      logger
    end

  end


  class LogWriter
    def write(event)
      Collector.instance.collect event
    end

    def close
      nil
    end

    def formatter
      proc do |severity, _, _, msg|
        event = Varlog::LogEvent.new(Span.current, Time.now.to_f, msg, severity)
        event
      end
    end

  end

end