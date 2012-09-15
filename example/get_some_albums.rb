require "./picasa.rb"

client = Picasa::Client.new(:user_id => "your_gmail_account", :password => "password")

begin
	# get some albums.
	albums = client.album.list.entries
	for album in albums do puts album.title end
	
rescue Picasa::ForbiddenError
	puts "You have the wrong user_id or password."
end