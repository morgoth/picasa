class Picasa::Photo
  attr_reader :client

  def initialize(user_id = nil)
    @client = Picasa::Client.new(user_id)
  end

  # Returns photo list
  # When user_id is present photos will be scoped to that user
  # otherwise community public photos will be returned
  #
  def list(options = {})
    user_id = options.delete(:user_id) || client.user_id || "all"
    uri = URI.parse("/data/feed/api/user/#{user_id}")
    client.get(uri.path, default_options.merge(options))
  end

  private

  def default_options
    {:kind => "photo"}
  end
end
