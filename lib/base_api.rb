require 'grape'
require 'dotenv/load'
require 'sequel'
require 'rack/cors'
require 'pry'

class BaseAPI < Grape::API

  # Cors
  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: [:get, :post, :put, :delete, :options]
    end
  end

  # ActiveRecordModel is just an alias to Sequel::Model class:
  Sequel::Model.plugin :json_serializer
  Sequel::Model.plugin :polymorphic
  Sequel.extension :date_arithmetic
  Sequel.split_symbols = true

  # Database access constants:
  Sequel.connect(ENV['DATABASE_URL'])

  # Autoloading classes
  %w[
    utils
    config
    models
    controllers
  ].each{ |folder| Dir["#{Dir.pwd}/lib/#{folder}/*.rb"].each{|file| require_relative file} }

  # Load controllers
  mount Controller::Authenticable
  mount Controller::User
  # ...

end
