require 'jwt'

module Utils
  class Auth

    def self.encode payload
      JWT.encode payload, ENV['API_KEY'], 'HS256'
    end

    def self.decode token
      begin
        JWT.decode token.split(' ')[1], ENV['API_KEY'], true, { algorithm: 'HS256' }
      rescue => e
        raise ArgumentError.new 'Invalid token'
      end
    end

    def self.get_current_user token
      self.decode(token).first
    end

  end
end
