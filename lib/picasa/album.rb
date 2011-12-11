module Picasa
  class Album
    attr_reader :client

    def initialize(user_id = nil, password = nil)
      @client = Picasa::Client.new(user_id, password)
    end

    # Returns album list
    #
    def list(options = {})
      uri  = URI.parse("/data/feed/api/user/#{client.user_id}")
      feed = client.get(uri.path, options)

      return feed["feed"] if feed && feed.has_key?("feed")
      feed
    end

    # Returns photo list
    #
    # ==== Options
    # * <tt>:max_results</tt>
    # * <tt>:tag</tt>
    def show(album_id, options = {})
      uri  = URI.parse("/data/feed/api/user/#{client.user_id}/albumid/#{album_id}")
      feed = client.get(uri.path, options)

      return feed["feed"] if feed && feed.has_key?("feed")
      feed
    end
    alias photos show
  end
end
