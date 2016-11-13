require 'sinatra'
require 'net/http'
require 'varlog'

configure do
  use Varlog::Middleware
end

get '/status' do
  uri = URI.parse("http://google.com/")
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  response.body
end
