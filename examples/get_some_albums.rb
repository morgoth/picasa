require "picasa"

# get some albums.
client = Picasa::Client.new(user_id: "your-gmail-account@gmail.com", access_token: "oauth-access-token")

albums = client.album.list.entries
albums.each { |album| puts album.title }
