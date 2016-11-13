require 'request_store'
require 'benchmark'
require 'net/http'

module Net
  class HTTP
    alias_method :orig_request, :request

    def request(req, body = nil)
      trace_id = RequestStore[:trace_id]
      timestamp = Time.now.to_i
      endpoint = req.path

      request_event = Varlog::HTTPRequestEvent.new(trace_id, timestamp, req.method, endpoint)
      Varlog::Collector.collect(request_event)
      rtt = Benchmark.realtime do
        @response = orig_request(req, body)
      end
      response_event = Varlog::HTTPResponseEvent.new(trace_id, timestamp, @response.code, endpoint, rtt)
      Varlog::Collector.collect(response_event)

      @response
    end

  end
end
