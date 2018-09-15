require 'jwt'

module Config
  class Auth

    def self.encode payload
      JWT.encode payload, ENV['API_KEY'], 'HS256'
    end

    def self.decode token
      JWT.decode token, ENV['API_KEY'], true, { algorithm: 'HS256' }
    end

    def self.get_current_user token
      self.decode(token).first
    end

  end
end
