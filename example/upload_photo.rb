require "picasa"

# upload photo
begin
  client = Picasa::Client.new(:user_id => "your_gmail_account", :password => "password")

  photo_bin = File.binread("./test.jpg")

  albums = client.album.list.entries
  album = albums.find { |album| album.title == "New Album" }

  client.photo.create(album.id,
    {
      :binary => photo_bin,
      :content_type => "image/jpeg",
      :title => "Test Photo",
      :summary => "Hoge hoge"
    }
  )

rescue Picasa::ForbiddenError
  puts "You have the wrong user_id or password."
end
