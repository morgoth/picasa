class Picasa::Tag
  attr_reader :client

  def initialize(user_id = nil)
    @client = Picasa::Client.new(user_id)
  end

  # Returns user tag list
  #
  # ==== Options
  # * <tt>:album_id</tt> scope tags to given album
  # * <tt>:photo_id</tt> scope tags to given photo (album_id must be present also)
  def list(options = {})
    raise ::ArgumentError.new("album_id must be specified when passing photo_id") if options[:photo_id] && !options[:album_id]
    uri = "/data/feed/api/user/#{client.user_id}"

    if options[:album_id]
      uri << "/albumid/#{options.delete(:album_id)}"
      uri << "/photoid/#{options.delete(:photo_id)}" if options[:photo_id]
    end
    uri = URI.parse(uri)
    feed = client.get(uri.path, default_options.merge(options))

    return feed["feed"] if feed && feed.has_key?("feed")
    feed
  end

  private

  def default_options
    {:kind => "tag"}
  end
end
