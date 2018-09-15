require 'grape'
require 'rack/contrib'

module Controller
  class Authenticable < Grape::API
    prefix 'api'
    version 'v1', using: :path

    use Rack::JSONP
    format :json

    before do
      begin
        token = request.headers['Authorization'].split ' '
        @@current_user = Utils::Auth::get_current_user token[1]
        puts @@current_user
      rescue => e
        error!({ error: 'unauthorized' }, 401)
      end
    end

    post '/auth' do
      content_type 'application/json'
      status 200

      begin

        # ...

      rescue => e
        error!({ error: e }, 400)
      end

      { data: @@current_user }
    end

    get '/user' do
      content_type 'application/json'
      status 200

      begin
        { data: @@current_user }
      rescue => e
        error!({ error: e.message }, e.status)
      end

    end


  end
end
