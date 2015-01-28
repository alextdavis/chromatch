require 'rubygems'
require 'bundler'

Bundler.require

require './app.rb'

# Routes
Dir['./routes/*.rb'].each { |file| require file }

# Helpers
Dir['./helpers/*.rb'].each { |file| require file }

# Models
DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://db/main.db')
Sequel::Model.plugin :json_serializer
Dir['./models/*.rb'].each { |file| require file }

run Chromatch
