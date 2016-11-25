require 'request_store'
require 'benchmark'
require 'net/http'

module Net
  class HTTP
    alias_method :orig_request, :request

    def request(req, body = nil)
      timestamp = Time.now.to_i
      endpoint = req.path
      req.add_field('X-Trace-Id', Varlog::Span.trace_id)
      req.add_field('X-Parent-Id', Varlog::Span.span_id)

      current_span = Varlog::Span.current
      request_event = Varlog::HTTPRequestEvent.new(current_span, timestamp, req.method, endpoint)
      Varlog::Collector.instance.collect(request_event)
      rtt = Benchmark.realtime do
        @response = orig_request(req, body)
      end
      response_event = Varlog::HTTPResponseEvent.new(current_span, timestamp, @response.code, endpoint, rtt)
      Varlog::Collector.instance.collect(response_event)

      @response
    end

  end
end
