require "helper"

describe Picasa::WebAlbums do
  it "should parse albums page" do
    page = fixture_file("albums")
    FakeWeb.register_uri(:get, "picasaweb.google.com/data/feed/api/user/some.user", :response => page)

    albums = Picasa.albums(:google_user => "some.user")
    assert_equal 5, albums.count
    assert_equal "SAPS in da akcion :P", albums.first[:title]
    assert_equal 10, albums[2][:photos_count]
    assert_equal "5277503612406515713", albums.first[:id]
    refute_nil albums.first[:photo]
    refute_nil albums.first[:thumbnail]
    refute_nil albums.first[:slideshow]
  end

  it "should parse photos page" do
    page = fixture_file("photos")
    FakeWeb.register_uri(:get, "picasaweb.google.com/data/feed/api/user/some.user/albumid/666", :response => page)

    photos = Picasa.photos(:google_user => "some.user", :album_id => "666")
    assert_equal 10, photos[:photos].count
    refute_nil photos[:slideshow]
    refute_nil photos[:photos].first[:thumbnail_1]
    refute_nil photos[:photos].first[:thumbnail_2]
    refute_nil photos[:photos].first[:thumbnail_3]
    assert_nil photos[:photos].first[:title]
    assert_equal "http://lh5.ggpht.com/_Kp7xCOU0f_U/SQS8EFqEXjI/AAAAAAAAAFo/aUOA6byXAuE/Jurek.JPG", photos[:photos].first[:photo]
  end

  it "should raise argument error if google user is not present" do
    assert_raises ArgumentError do
      Picasa::WebAlbums.new
    end
  end

  it "should raise argument error if album_id is not present" do
    assert_raises ArgumentError do
      Picasa.photos :google_user => "some.user"
    end
  end
end
