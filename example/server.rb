require 'sinatra'
require 'net/http'
require 'varlog'

configure do
  use Varlog::Middleware
end

get '/google' do
  uri = URI.parse("http://google.com/")
  Net::HTTP.get(uri)  
end
