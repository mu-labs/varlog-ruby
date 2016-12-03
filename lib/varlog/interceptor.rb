require 'benchmark'

module Net
  class HTTP
    alias_method :orignal_request, :request

    def request(req, body = nil, &block)

      if started?
        timestamp = Time.now.to_f
        endpoint = req.path
        req.add_field('X-Trace-Id', Varlog::Span.trace_id)
        req.add_field('X-Parent-Span-Id', Varlog::Span.span_id)
        req.add_field('X-Parent', Varlog::Span.span_name)

        current_span = Varlog::Span.current
        request_event = Varlog::HTTPRequestEvent.new(current_span, timestamp, req.method, endpoint)
        Varlog::Collector.instance.collect(request_event)
      end

      rtt = Benchmark.realtime do
        @response = orignal_request(req, body, &block)
      end

      if started?
        timestamp = Time.now.to_f
        current_span = Varlog::Span.current
        response_event = Varlog::HTTPResponseEvent.new(current_span, timestamp, @response.code, endpoint, rtt)
        Varlog::Collector.instance.collect(response_event)
      end

      @response
    end

  end
end
