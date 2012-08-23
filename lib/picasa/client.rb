module Picasa
  class Client
    attr_reader :credentials

    # @param [Hash] credentials
    # @option options [String] :user_id google username/email
    # @option options [String] :password password for given username/email
    def initialize(credentials = {})
      credentials[:user_id] || raise(ArgumentError, "You must specify user_id")
      @credentials = credentials
    end

    # @return [API::Album]
    def album
      API::Album.new(credentials)
    end
  end
end
