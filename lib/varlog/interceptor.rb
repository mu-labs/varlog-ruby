require 'benchmark'

module Net
  class HTTP
    alias_method :orignal_request, :request

    def request(req, body = nil, &block)
      timestamp = Time.now.to_i
      endpoint = req.path
      req.add_field('X-Trace-Id', Varlog::Span.trace_id)
      req.add_field('X-Parent-Id', Varlog::Span.span_id)

      current_span = Varlog::Span.current

      if started?
        request_event = Varlog::HTTPRequestEvent.new(current_span, timestamp, req.method, endpoint)
        Varlog::Collector.instance.collect(request_event)
      end

      rtt = Benchmark.realtime do
        @response = orignal_request(req, body, &block)
      end

      if started?
        response_event = Varlog::HTTPResponseEvent.new(current_span, timestamp, @response.code, endpoint, rtt)
        Varlog::Collector.instance.collect(response_event)
      end

      @response
    end

  end
end
