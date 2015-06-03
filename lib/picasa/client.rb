module Picasa
  class Client
    attr_reader :user_id
    attr_accessor :access_token, :authorization_header

    # @param [Hash] credentials
    # @option credentials [String] :user_id google username/email
    # @option credentials [String] :authorization_header custom authorization header (i.e. taken from OAuth2)
    # @option credentials [String] :access_token picasa OAuth2 access token
    def initialize(credentials = {})
      if credentials[:password]
        raise(ArgumentError, "Providing password has no effect as google login by password API is not active anymore https://developers.google.com/accounts/docs/AuthForInstalledApps")
      end
      @user_id      = credentials[:user_id] || raise(ArgumentError, "You must specify user_id")
      @access_token = credentials[:access_token]
      if credentials[:authorization_header]
        puts "Passing authorization_header is deprecated. Please pass access_token"
      end
      @authorization_header = credentials[:authorization_header]
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

    # @return [API::Comment]
    #
    # @example
    #   client = Picasa::Client.new(user_id: "my.email@google.com")
    #   comment_list = client.comment.list(album_id: "988", photo_id: "123")
    #   comment_list.entries.map &:content
    #   # => "nice photo!"
    def comment
      API::Comment.new(credentials)
    end

    private

    def credentials
      {user_id: user_id}.tap do |credentials|
        credentials[:access_token]         = access_token         if access_token
        credentials[:authorization_header] = authorization_header if authorization_header
      end
    end
  end
end
