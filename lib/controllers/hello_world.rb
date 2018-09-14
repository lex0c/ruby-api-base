require 'grape'

module Controller
    class HelloWorld < Grape::API
        prefix 'api'
        format :json

        get '/hello-world' do
            { msg: 'Hello World!!!' }
        end

    end
end
