require "picasa"

client = Picasa::Client.new(user_id: "your-gmail-account@gmail.com", access_token: "oauth-access-token")
# create new album.
client.album.create(
  :title => "New Album",
  :summary => "This is a new album.",
  :access => "protected"
)
