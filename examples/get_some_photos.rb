require "picasa"

# get some photos in an album
begin
  client = Picasa::Client.new(:user_id => "your_gmail_account", :password => "password")

  albums = client.album.list.entries
  album = albums.find { |album| album.title == "New Album" }

  photos = client.album.show(album.id).entries

  photos.each { |photo| puts photo.title }

rescue Picasa::ForbiddenError
  puts "You have the wrong user_id or password."
end
