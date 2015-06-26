# Download photos example
# Matthew Epler, Sept 2012

require "picasa"
require "open-uri"

username = "user@gmail.com"
dir = "/Users/path.../"

client = Picasa::Client.new(:user_id => username)
albums = client.album.list.entries

albums.each do |album|
	Dir.chdir(dir)
	this_album = client.album.show(album.id).entries
	Dir.mkdir(album.title)
	Dir.chdir(album.title)

	for photo in this_album
		begin
			get_string = photo.content.src
			puts "processing" << photo.id

		rescue Exception => e
			puts photo.id << "  **ERROR**"
			puts e
		end

	  open(get_string) do |f|
  		File.open(photo.title, "wb") do |file|
        file.puts f.read
  	  end
	  end
	  puts "======================================"
	end
end
