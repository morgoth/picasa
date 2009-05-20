require 'test_helper'

class PicasaTest < Test::Unit::TestCase
  context 'with albums page' do
    setup do
			page = fixture_file('albums')
			FakeWeb.register_uri(:get, "picasaweb.google.com/data/feed/api/user/some.user", :response => page)
		end

    should 'parse it' do
      albums = Picasa.albums('some.user')
			assert_equal albums.count, 5
			assert_equal albums.first[:title], "SAPS in da akcion :P"
			assert_equal albums[2][:photos_count].to_i, 10
			assert_equal albums.first[:id], "5277503612406515713"
    end
  end

  context 'with photos page' do
    setup do
			page = fixture_file('photos')
			FakeWeb.register_uri(:get, "picasaweb.google.com/data/feed/api/user/some.user/albumid/666", :response => page)
		end

    should 'parse it' do
      photos = Picasa.photos('some.user', '666')
			assert_equal photos[:photos].count.to_i, 10
			assert_not_nil photos[:slideshow]
			assert_not_nil photos[:photos].first[:thumbnail_1]
			assert_not_nil photos[:photos].first[:thumbnail_2]
			assert_not_nil photos[:photos].first[:thumbnail_3]
			assert_nil photos[:photos].first[:title]
			assert_equal photos[:photos].first[:photo], "http://lh5.ggpht.com/_Kp7xCOU0f_U/SQS8EFqEXjI/AAAAAAAAAFo/aUOA6byXAuE/Jurek.JPG"
    end
  end
end
