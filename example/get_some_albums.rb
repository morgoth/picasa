require "./picasa.rb"

client = Picasa::Client.new(:user_id => "your_gmail_account", :password => "password")

begin
	# get some albums.
	albums = client.album.list.entries
	for album in albums do puts album.title end
	
rescue Picasa::ForbiddenError
	puts "user_id is not found"
end