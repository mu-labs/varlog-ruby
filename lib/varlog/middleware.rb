module Varlog
  class Middleware

    def initialize(app)
      @app = app
    end

    def call(env)

      parent_span_id = env['HTTP_X_SPAN_ID']
      trace_id = env['HTTP_X_TRACE_ID']

      Varlog::Span.build trace_id, parent_span_id

      res = @app.call(env)
      res[1]['X-Trace-Id'] = trace_id
      res[1]['X-Span-Id'] = Span.span_id
      res
    ensure
      Varlog::Span.end
    end

  end
end
