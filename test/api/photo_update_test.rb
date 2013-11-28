require 'helper'


describe Picasa::API::Photo do
  describe "#update" do
    it "updates photo details" do
      VCR.use_cassette("photo-update") do
        attributes = { :title => "gem-test", :summary => "photo-update-test"}
        album_api = Picasa::API::Album.new(:user_id => "lwoggardner", :authorization_header => AuthHeader)

        album = album_api.create(attributes)

        photo_api = Picasa::API::Photo.new(:user_id => "lwoggardner", :authorization_header => AuthHeader) 

        photo = photo_api.create(album.id,:file_path => fixture_path("lena.jpg"), :title => "Lena", :summary => "fixture photo")

        photo = photo_api.update(album.id,photo.id, :title => "Lena updated", :summary => "")  

        assert_equal "Lena updated", photo.title
        assert_equal "", photo.summary

        new_timestamp = 1385553053
        photo = photo_api.update(album.id,photo.id, :summary => "done", :timestamp => new_timestamp, :keywords => "one, two, three")

        assert_equal "done", photo.summary
        assert_equal "1385553053", photo.timestamp
        assert_equal "one, two, three", photo.media.keywords

        album_api.delete(album.id)
      end
    end

    it "updates image binary"

    it "moves photos between albums" do
      VCR.use_cassette("photo-move") do
        album_api = Picasa::API::Album.new(:user_id => "lwoggardner", :authorization_header => AuthHeader)
        photo_api = Picasa::API::Photo.new(:user_id => "lwoggardner", :authorization_header => AuthHeader) 

        source_album = album_api.create(:title => "gem-test", :summary => "move source")
        target_album = album_api.create(:title => "gem-test", :summary => "move target")

        photo = photo_api.create(source_album.id, :file_path => fixture_path("lena.jpg"), :title => "Lena")
        
        photo = photo_api.update(source_album.id, photo.id, :to_album_id => target_album.id)

        assert_equal target_album.id, photo.album_id

        source_album = album_api.show(source_album.id)
        target_album = album_api.show(target_album.id)

        assert target_album.photos.any? { |p| p.id == photo.id }
        refute source_album.photos.any? { |p| p.id == photo.id }

        album_api.delete(source_album.id)
        album_api.delete(target_album.id)
      end
    end

  end
end
