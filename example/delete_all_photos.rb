require "picasa"

# delete all photos in an album.
begin
  client = Picasa::Client.new(:user_id => "your_gmail_account", :password => "password")
  albums = client.album.list.entries
  album = albums.find { |album| album.title == "New Album" }

  photos = client.album.show(album.id).entries

  photos.each do |photo|
    if client.tag.delete(album_id, photo.id)
      "#{photo.title} deleted"
    else
      "#{photo.title} failed to delete"
    end
  end
rescue Picasa::ForbiddenError
  puts "You have the wrong user_id or password."
end
