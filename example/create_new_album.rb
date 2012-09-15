require "picasa"

begin
  client = Picasa::Client.new(:user_id => "your_gmail_account", :password => "password")
  # create new album.
  client.album.create(
      :title => "New Album",
      :summary => "This is a new album.",
      :access => "protected")

rescue Picasa::ForbiddenError
  puts "You have the wrong user_id or password."
end
