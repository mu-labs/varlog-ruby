module Varlog
  class Middleware

    def initialize(app)
      @app = app
    end

    def call(env)

      parent_span_id = env['HTTP_X_PARENT_SPAN_ID']
      parent_name = env['HTTP_X_PARENT']
      trace_id = env['HTTP_X_TRACE_ID']

      Varlog::Span.build Varlog.app_name, trace_id, parent_span_id, parent_name

      res = @app.call(env)
      res[1]['X-Trace-Id'] = Span.trace_id
      res[1]['X-Span-Id'] = Span.span_id
      res
    ensure
      Varlog::Span.end
    end

  end
end
