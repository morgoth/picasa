class Picasa::Album
  attr_reader :client

  def initialize(user_id = nil)
    @client = Picasa::Client.new(user_id)
  end

  # Returns album list
  #
  def list(options = {})
    uri = URI.parse("/data/feed/api/user/#{client.user_id}")
    client.get(uri.path, options)
  end

  # Returns photo list
  #
  # ==== Options
  # * <tt>:max_results</tt>
  # * <tt>:tag</tt>
  def show(album_id, options = {})
    uri = URI.parse("/data/feed/api/user/#{client.user_id}/albumid/#{album_id}")
    client.get(uri.path, options)
  end
  alias photos show
end
