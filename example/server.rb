require 'sinatra'
require 'net/http'
require 'varlog'


Varlog.app_name = "example"

configure do
  use Varlog::Middleware
end

logger = Varlog::Logger.new

get '/google' do
  uri = URI.parse("http://google.com/")
  logger.info "hello world"
  Net::HTTP.get(uri)  
end
