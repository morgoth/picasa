require "picasa"

# upload photo
client = Picasa::Client.new(user_id: "your-gmail-account@gmail.com", access_token: "oauth-access-token")

photo_bin = File.binread("./test.jpg")

albums = client.album.list.entries
album = albums.find { |album| album.title == "New Album" }

client.photo.create(album.id,
  {
    :binary => photo_bin,
    :content_type => "image/jpeg",
    :title => "Test Photo",
    :summary => "Hoge hoge"
  }
)
