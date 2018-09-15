require 'grape'
require 'rack/contrib'

module Controller
  class Authenticable < Grape::API
    prefix 'api'
    version 'v1', using: :path

    use Rack::JSONP
    format :json

    User = Models::User

    post '/auth' do
      content_type 'application/json'
      status 200

      begin
        raise ArgumentError.new 'email and password are required params' unless params.has_key?(:email) || params.has_key?(:password)

        user = User.where(email: params[:email]).first

        raise ArgumentError.new 'Email not found!' if user.blank?

        if BCrypt::Password.new(user[:password]) == params[:password]
          # user.delete(:password)
          # user.delete(:created_at)
          # user.delete(:updated_at)
        else
          raise ArgumentError.new 'Invalid password'
        end

      rescue => e
        error!({ error: e }, 400)
      end

      { token: Utils::Auth.encode(user) }
    end

    get '/current_user' do
      content_type 'application/json'
      status 200

      begin
        raise ArgumentError.new 'Invalid token' unless request.headers['Authorization']
        { user: Utils::Auth.get_current_user(request.headers['Authorization']) }
      rescue => e
        error!({ error: e.message }, 401)
      end

    end


  end
end
