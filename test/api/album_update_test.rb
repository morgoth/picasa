require "helper"

describe Picasa::API::Album do
  describe "#update" do
    it "updates album summary" do
      VCR.use_cassette("album-update") do
        attributes = {:title => "gem-test", :summary => "created from test suite", :access => "protected",
          :location => "Sydney"}
        api = Picasa::API::Album.new(:user_id => "lwoggardner@gmail.com", :authorization_header => AuthHeader)

        album = api.create(attributes)
        original_timestamp = album.timestamp

        album = api.show(album.id)
        assert_equal "created from test suite", album.summary

        album = api.update(album.id, :summary => "updated")

        assert_equal "Sydney", album.location
        assert_equal "updated", album.summary
        assert_equal "protected", album.access
        assert_equal  original_timestamp, album.timestamp

        album = api.show(album.id)

        assert_equal "Sydney", album.location
        assert_equal "updated", album.summary
        assert_equal "protected", album.access

        new_timestamp = 1385553052
        album = api.update(album.id, :location => "Melbourne", :title => "gem-test-updated", :summary => "updated again",
          :access => "private", :timestamp => new_timestamp)

        assert_equal "Melbourne", album.location
        assert_equal "updated again", album.summary
        assert_equal "private", album.access
        assert_equal  new_timestamp, album.timestamp.to_i

        api.delete(album.id)
      end
    end
  end
end
