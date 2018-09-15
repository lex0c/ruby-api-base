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
        @@current_user = Config::Auth::get_current_user token[1]
        puts @@current_user
      rescue => e
        error!({ error: 'unauthorized' }, 403)
      end
    end

    post '/auth' do
      content_type 'application/json'
      { user: @@current_user }
    end

    # ...

  end
end
