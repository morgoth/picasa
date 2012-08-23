module Picasa
  class Client
    attr_reader :credentials

    # @param [Hash] credentials
    # @option credentials [String] :user_id google username/email
    # @option credentials [String] :password password for given username/email
    def initialize(credentials = {})
      credentials[:user_id] || raise(ArgumentError, "You must specify user_id")
      @credentials = credentials
    end

    # @return [API::Album]
    #
    # @example
    #   client = Picasa::Client.new(user_id: "my.email@google.com")
    #   album_list = client.album.list
    #   album_list.title
    #   # => "My album"
    def album
      API::Album.new(credentials)
    end
  end
end
