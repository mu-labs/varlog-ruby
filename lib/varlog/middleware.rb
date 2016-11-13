require 'request_store'
require 'securerandom'

module Varlog
  class Middleware

    def initialize(app)
      @app = app
    end

    def call(env)
      RequestStore.begin!
      RequestStore[:trace_id] = SecureRandom.uuid
      @app.call(env)
    ensure
      RequestStore.end!
      RequestStore.clear!
    end

  end
end
