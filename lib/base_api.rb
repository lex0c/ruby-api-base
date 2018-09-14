require 'grape'
require 'dotenv/load'
require 'sequel'
require 'rack/cors'

class BaseAPI < Grape::API

  # Autoloading classes
  %w[
    controllers
    models
    utils
  ].each{ |folder| Dir["#{Dir.pwd}/lib/#{folder}/*.rb"].each{|file| require_relative file} }

  # Load controllers
  mount Controller::HelloWorld
  # ...

  # ActiveRecordModel is just an alias to Sequel::Model class:
  Sequel::Model.plugin :json_serializer
  Sequel.split_symbols = true

  # Database access constants:
  DB = Sequel.connect(ENV['DATABASE_URL'])
  DB.extension :date_arithmetic
  DB.extension :pg_json

  # Cors
  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: [:get, :post, :put, :delete, :options]
    end
  end

end
