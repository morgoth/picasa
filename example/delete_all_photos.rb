require "picasa.rb"

client = Picasa::Client.new(:user_id => "your_gmail_account", :password => "password")

# delete all photos in an album.
begin
    # NOTE:
    # If you want a list of photos, please call a show method.
    albums = client.album.list.entries
    photos = nil
    album_id = nil
    for album in albums do
        if album.title == "New Album" then
            # get album instance
            album_id = album.id
            photos = client.album.show(album.id).entries
            # ---case of failure---
            # photos = client.album.entries
            break
        end
    end
    
    for photo in photos do
        if !client.photo.delete(album_id, photo.id) then
            puts "failed to delete"
        end
    end
    
rescue Picasa::ForbiddenError
    puts "You have the wrong user_id or password."
end