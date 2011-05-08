require 'rubygems'
require 'sinatra'
require 'net/http'
require 'uri'

class App < Sinatra::Base
  get '/hello' do
    sleep(1)
    "world"
  end

  get '/test' do
    url = 'http://localhost:9090/hello'
    "Received: #{Net::HTTP.get(URI.parse(url))}"
  end

  get '/gc' do
    JRuby.gc
    'ok'
  end
end

run App

