require 'request_store'

module Net
  class HTTP
    alias_method :orig_request, :request

    def request(req, body = nil)
      trace_id = RequestStore[:trace_id]
      timestamp = Time.now.to_i
      endpoint = req.path

      request_event = new Varlog::HTTPRequestEvent(trace_id, timestamp, req.method, endpoint)
      Collector.collect(request_event)
      rtt = Bechmark.realtime do
        @response = orig_request(req, body)
      end
      response_event = new Varlog::HTTPResponseEvent(trace_id, timestamp, res.code, endpoint, rtt)
      Collector.collect(response_event)

      @response
    end

  end
end
