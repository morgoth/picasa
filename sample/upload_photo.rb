require "./picasa.rb"

client = Picasa::Client.new(:user_id => "your_gmail_account", :password => "password")

photo_bin = File.binread("./test.jpg")

# upload photo
begin
	# create method needs an album's id.
	albums = client.album.list.entries
	test_album = nil
	for album in albums do
		if album.title == "New Album" then
			test_album = album
			break
		end
	end
	
	photo = client.photo.create(
		test_album.id, 
		{:binary => photo_bin, 
		:content_type => "image/jpeg", 
		:title => "Test Photo",
		:summary => "Hoge hoge"})
	
rescue Picasa::ForbiddenError
	puts "user_id is not found"
end