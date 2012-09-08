require "./picasa.rb"

client = Picasa::Client.new(:user_id => "your_gmail_account", :password => "password")

begin
	# get some albums.
	client.album.create(:title => "New Album")
	
rescue Picasa::ForbiddenError
	puts "user_id is not found"
end