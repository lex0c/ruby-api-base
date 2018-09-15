require 'grape'
require 'dotenv/load'
require 'sequel'
require 'rack/cors'
require 'pry'

class BaseAPI < Grape::API

  # Autoloading classes
  %w[
    config
    controllers
    models
    utils
  ].each{ |folder| Dir["#{Dir.pwd}/lib/#{folder}/*.rb"].each{|file| require_relative file} }

  # Load controllers
  mount Controller::Authenticable
  # ...

  # ActiveRecordModel is just an alias to Sequel::Model class:
  Sequel::Model.plugin :json_serializer
  Sequel.split_symbols = true

  # Database access constants:
  DB = Sequel.connect(ENV['DATABASE_URL'])

  # Cors
  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: [:get, :post, :put, :delete, :options]
    end
  end

end
