module Varlog
  module Collector
    class << self
      def collect(event)
        p event
      end
    end
  end
end
