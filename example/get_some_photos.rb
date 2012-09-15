require "./picasa.rb"

client = Picasa::Client.new(:user_id => "your_gmail_account", :password => "password")

# get some photos in an album
begin
	# NOTE:
	# If you want a list of photos, please call a show method.
	albums = client.album.list.entries
	new_album = nil
	for album in albums do
		if album.title == "New Album" then
			# get album instance
			new_album = client.album.show(album.id)
			# ---case of failure---
			# photos = client.album.entries
			break
		end
	end
	
	new_album.entries.each{|photo| puts photo.title }
	
rescue Picasa::ForbiddenError
	puts "You have the wrong user_id or password."
end