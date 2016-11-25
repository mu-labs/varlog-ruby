require 'securerandom'

module Varlog
  class Span
    def self.current
      {
          trace_id: store[:trace_id],
          span_id: store[:span_id],
          parent_id: store[:parent_span_id]
      }
    end

    def self.store
      RequestStore
    end

    def self.method_missing(m)
      store[m.to_sym]
    end

    def self.build(trace_id, parent_span_id)
      RequestStore.store

      current_span_id = SecureRandom.uuid
      trace_id = trace_id.nil? ? SecureRandom.uuid : trace_id

      RequestStore[:trace_id] = trace_id
      RequestStore[:parent_span_id] = parent_span_id
      RequestStore[:span_id] = current_span_id

    end

    def self.end
      RequestStore.clear!
    end
  end
end