require "picasa"

# add tags to your photos in an album.
client = Picasa::Client.new(user_id: "your-gmail-account@gmail.com", access_token: "oauth-access-token")
albums = client.album.list.entries
album = albums.find { |album| album.title == "New Album" }

photos = client.album.show(album.id).entries

photos.each do |photo|
  client.tag.create(
      :album_id => album.id,
      :photo_id => photo.id,
      :tag_name => "test")
end
