class Picasa::Album
  attr_reader :client, :user_id

  def initialize(user_id)
    @client = Picasa::Client.new(user_id)
  end

  def list
    uri = URI.parse("/data/feed/api/user/#{client.user_id}")
    client.get(uri.path)
  end

  def show(album_id)
    uri = URI.parse("/data/feed/api/user/#{client.user_id}/albumid/#{album_id}")
    client.get(uri.path)
  end
  alias photos show
end
