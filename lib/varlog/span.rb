require 'request_store'
require 'request_store'
require 'securerandom'

module Varlog
  class Span
    def self.current
      {
          trace_id: RequestStore[:trace_id],
          span_id: RequestStore[:span_id],
          parent_id: RequestStore[:parent_span_id]
      }
    end

    def self.method_missing(m)
      RequestStore[m.to_sym]
    end

    def self.build(trace_id, parent_span_id)
      RequestStore.begin!

      current_span_id = SecureRandom.uuid
      trace_id = trace_id.nil? ? SecureRandom.uuid : trace_id

      RequestStore[:trace_id] = trace_id
      RequestStore[:parent_span_id] = parent_span_id
      RequestStore[:span_id] = current_span_id

    end

    def self.end
      RequestStore.end!
      RequestStore.clear!
    end
  end
end