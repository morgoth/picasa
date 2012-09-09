require "./picasa.rb"

client = Picasa::Client.new(:user_id => "your_gmail_account", :password => "password")

begin
	# create new album.
	client.album.create(:title => "New Album")
	
rescue Picasa::ForbiddenError
	puts "user_id is not found"
end