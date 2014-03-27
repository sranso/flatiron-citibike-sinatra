require 'rubygems'
require 'bundler'
require "sinatra/reloader"

Bundler.require

Dir.glob('./lib/*.rb') do |model|
  require model
end

module Citibike
	class App < Sinatra::Application
    configure :development do
      register Sinatra::Reloader
    end

    before do
      json = File.open("data/citibikenyc.json").read
      @data = MultiJson.load(json) # a ruby hash of the data from JSON file
      @data.each do |hash|
        hash["lng"] = hash["lng"]/1000000.to_f
        hash["lat"] = hash["lat"]/1000000.to_f
      end
    end

    get '/' do
      erb :home # will print out the contents of @data
    end

    get '/form' do
      erb :form
    end

    post '/map' do
      @start = params["start"]
      @end = params["end"]
      erb :map
    end

    get '/map' do
      erb :map
    end

  end
end