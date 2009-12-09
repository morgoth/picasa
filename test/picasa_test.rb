require 'test_helper'

class PicasaTest < Test::Unit::TestCase
  context 'with albums page' do
    setup do
      page = fixture_file('albums')
      FakeWeb.register_uri(:get, "picasaweb.google.com/data/feed/api/user/some.user", :response => page)
    end

    should 'parse it' do
      albums = Picasa.albums(:google_user => 'some.user')
      assert_equal 5, albums.count
      assert_equal "SAPS in da akcion :P", albums.first[:title]
      assert_equal 10, albums[2][:photos_count]
      assert_equal "5277503612406515713", albums.first[:id]
      assert_not_nil albums.first[:photo]
      assert_not_nil albums.first[:thumbnail]
    end
  end

  context 'with photos page' do
    setup do
      page = fixture_file('photos')
      FakeWeb.register_uri(:get, "picasaweb.google.com/data/feed/api/user/some.user/albumid/666", :response => page)
    end

    should 'parse it' do
      photos = Picasa.photos(:google_user => 'some.user', :album_id => '666')
      assert_equal 10, photos[:photos].count
      assert_not_nil photos[:slideshow]
      assert_not_nil photos[:photos].first[:thumbnail_1]
      assert_not_nil photos[:photos].first[:thumbnail_2]
      assert_not_nil photos[:photos].first[:thumbnail_3]
      assert_nil photos[:photos].first[:title]
      assert_equal "http://lh5.ggpht.com/_Kp7xCOU0f_U/SQS8EFqEXjI/AAAAAAAAAFo/aUOA6byXAuE/Jurek.JPG",
        photos[:photos].first[:photo]
    end
  end

  should "Raise argument error if google user is not present" do
    assert_raise ArgumentError do
      Picasa::WebAlbums.new
    end
  end

  should "Raise argument error if album_id is not present" do
    assert_raise ArgumentError do
      Picasa.photos :google_user => 'some.user'
    end
  end

  should "Not raise argument error if google user is set by class variable" do
    Picasa::WebAlbums.google_user = "some.user"
    assert_nothing_raised do
      Picasa::WebAlbums.new(nil)
    end
  end
end
