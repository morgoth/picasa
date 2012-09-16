module Picasa
  class Client
    attr_reader :user_id, :password, :authorization_header

    # @param [Hash] credentials
    # @option credentials [String] :user_id google username/email
    # @option credentials [String] :password password for given username/email
    # @option credentials [String] :authorization_header custom authorization header (i.e. taken from OAuth2)
    def initialize(credentials = {})
      @user_id              = credentials[:user_id] || raise(ArgumentError, "You must specify user_id")
      @password             = credentials[:password]
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
      authenticate if authenticates?
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
      authenticate if authenticates?
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
      authenticate if authenticates?
      API::Tag.new(credentials)
    end

    # @return [String]
    def authenticate
      response = Connection.new.post(
        :host => API_AUTH_URL,
        :headers => {"Content-Type" => "application/x-www-form-urlencoded"},
        :path => "/accounts/ClientLogin",
        :body => Utils.inline_query(
          "accountType" => "HOSTED_OR_GOOGLE",
          "Email"       => user_id,
          "Passwd"      => password,
          "service"     => "lh2",
          "source"      => "ruby-gem-v#{VERSION}"
        )
      )

      key = extract_auth_key(response.body)
      @authorization_header = "GoogleLogin auth=#{key}"
    end

    private

    def authenticates?
      password && authorization_header.nil?
    end

    def credentials
      {user_id: user_id}.tap do |credentials|
        credentials[:authorization_header] = authorization_header if authorization_header
      end
    end

    def extract_auth_key(data)
      response = data.split("\n").map { |v| v.split("=") }
      params = Hash[response]
      params["Auth"]
    end
  end
end
