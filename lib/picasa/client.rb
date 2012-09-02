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

    # @return [API::Photo]
    #
    # @example
    #   client = Picasa::Client.new(user_id: "my.email@google.com", password: "secret")
    #   photo = client.photo.create("album-id", title: "My picture", binary: "image-binary-data", content_type: "image/jpeg")
    #   photo.id
    #   # => "4322232322421"
    def photo
      API::Photo.new(credentials)
    end

    # @return [API::Tag]
    #
    # @example
    #   client = Picasa::Client.new(user_id: "my.email@google.com")
    #   tag_list = client.tag.list(album_id: "988", photo_id: "123")
    #   tag_list.title
    #   # => "holidays"
    def tag
      API::Tag.new(credentials)
    end
  end
end
