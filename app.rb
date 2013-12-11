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
    end

    get '/' do
      erb :home # will print out the contents of @data
    end

  end
end