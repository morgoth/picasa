require "picasa"

# get some albums.
begin
  client = Picasa::Client.new(:user_id => "your_gmail_account", :password => "password")

  albums = client.album.list.entries
  albums.each { |album| puts album.title }

rescue Picasa::ForbiddenError
  puts "You have the wrong user_id or password."
end
