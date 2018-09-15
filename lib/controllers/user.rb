require 'grape'
require 'rack/contrib'
require 'bcrypt'

module Controller
  class User < Grape::API
    include BCrypt

    prefix 'api'
    version 'v1', using: :path

    use Rack::JSONP
    format :json

    before do
      puts 'before requests'

      begin
        raise unless request.headers['Authorization']
        Utils::Auth.get_current_user request.headers['Authorization']
      rescue => e
        error!({ error: 'Valid token are required' }, 400)
      end

    end

    after do
      puts 'after requests'
    end

    User = Models::User

    post '/users' do
      content_type 'application/json'
      status 201

      begin
        User.insert(
          first_name: params[:first_name],
          last_name: params[:last_name],
          password: BCrypt::Password.create(params[:password]),
          email: params[:email]
        )
      rescue => e
        error!({ error: e }, 400)
      end

      { data: 'created' }
    end


  end
end
