module Picasa
  class Client
    attr_reader :user_id, :password

    def initialize(credentials = {})
      @user_id  = credentials[:user_id] || raise(ArgumentError.new("You must specify user_id"))
      @password = credentials[:password]
    end

    def album
      API::Album.new(:user_id => user_id, :password => password)
    end
  end
end
