module Picasa
  class Client
    attr_reader :credentials

    def initialize(credentials = {})
      credentials[:user_id] || raise(ArgumentError, "You must specify user_id")
    end

    def album
      API::Album.new(credentials)
    end
  end
end
