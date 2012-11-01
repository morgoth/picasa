# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::API::Album do
  describe "#list" do
    before do
      VCR.use_cassette("album-list") do
        @album_list = Picasa::API::Album.new(:user_id => "w.wnetrzak").list
      end
    end

    it "has author name" do
      assert_equal "Wojciech Wnętrzak", @album_list.author.name
    end

    it "has author uri" do
      assert_equal "https://picasaweb.google.com/106136347770555028022", @album_list.author.uri
    end

    it "has links" do
      assert_equal 4, @album_list.links.size
    end

    it "has title" do
      assert_equal "106136347770555028022", @album_list.title
    end

    it "has updated" do
      assert_equal "2012-11-01T04:47:09+00:00", @album_list.updated.to_s
    end

    it "has icon" do
      expected = "https://lh3.googleusercontent.com/-6ezHc54U8x0/AAAAAAAAAAI/AAAAAAAAAAA/PBuxm7Ehn6E/s64-c/106136347770555028022.jpg"
      assert_equal expected, @album_list.icon
    end

    it "has generator" do
      assert_equal "Picasaweb", @album_list.generator
    end

    it "has total_results" do
      assert_equal 1, @album_list.total_results
    end

    it "has start_index" do
      assert_equal 1, @album_list.start_index
    end

    it "has items_per_page" do
      assert_equal 1000, @album_list.items_per_page
    end

    it "has user" do
      assert_equal "106136347770555028022", @album_list.user
    end

    it "has nickname" do
      assert_equal "Wojciech Wnętrzak", @album_list.nickname
    end

    it "has thumbnail" do
      expected = "https://lh3.googleusercontent.com/-6ezHc54U8x0/AAAAAAAAAAI/AAAAAAAAAAA/PBuxm7Ehn6E/s64-c/106136347770555028022.jpg"
      assert_equal expected, @album_list.thumbnail
    end

    it "has entries" do
      assert_equal 1, @album_list.entries.size
    end
  end

  describe "#show" do
    before do
      VCR.use_cassette("album-show") do
        @album = Picasa::API::Album.new(:user_id => "w.wnetrzak").show("5239555770355467953")
      end
    end

    it "has author name" do
      assert_equal "Wojciech Wnętrzak", @album.author.name
    end

    it "has author uri" do
      assert_equal "https://picasaweb.google.com/106136347770555028022", @album.author.uri
    end

    it "has links" do
      assert_equal 5, @album.links.size
    end

    it "has published" do
      assert_nil @album.published
    end

    it "has updated" do
      assert_equal "2012-10-25T00:32:52+00:00", @album.updated.to_s
    end

    it "has title" do
      assert_equal "test", @album.title
    end

    it "has summary" do
      assert_nil @album.summary
    end

    it "has rights" do
      assert_equal "public", @album.rights
    end

    it "has id" do
      assert_equal "5239555770355467953", @album.id
    end

    it "has etag" do
      assert_equal "W/\"D0YDQ3s-fyp7ImA9WhNSEU8.\"", @album.etag
    end

    it "has name" do
      assert_equal "Test", @album.name
    end

    it "has location" do
      assert_equal "gdzieś", @album.location
    end

    it "has access" do
      assert_equal "public", @album.access
    end

    it "has timestamp" do
      assert_equal "1219906800000", @album.timestamp
    end

    it "has numphotos" do
      assert_equal 6, @album.numphotos
    end

    it "has user" do
      assert_equal "106136347770555028022", @album.user
    end

    it "has nickname" do
      assert_equal "Wojciech Wnętrzak", @album.nickname
    end

    it "has photo entries" do
      assert_equal 6, @album.entries.size
    end

    it "has allow_prints" do
      assert_equal true, @album.allow_prints
    end

    it "has allow_downloads" do
      assert_equal true, @album.allow_downloads
    end
  end

  describe "exceptions" do
    it "raises NotFound exception when album does not exist" do
      VCR.use_cassette("album-404") do
        assert_raises Picasa::NotFoundError, "Invalid entity id: non-existing" do
          Picasa::API::Album.new(:user_id => "w.wnetrzak").show("non-exisiting")
        end
      end
    end
  end

  describe "#create" do
    it "creates album" do
      VCR.use_cassette("album-create") do
        attributes = {:title => "gem-test", :summary => "created from test suite", :access => "protected",
                      :location => "Gilowice", :keywords => "test"}
        album = Picasa::API::Album.new(:user_id => "w.wnetrzak@gmail.com", :authorization_header => AuthHeader).create(attributes)

        assert_equal "gem-test", album.title
      end
    end

    it "gives correct parsed body fragment" do
      skip
      stub_request(:post, "https://www.google.com/accounts/ClientLogin").to_return(fixture("auth/success.txt"))
      stub_request(:post, "https://picasaweb.google.com/data/feed/api/user/w.wnetrzak@gmail.com").to_return(fixture("album/album-create.txt"))

      album_show = Picasa::API::Album.new(:user_id => "w.wnetrzak@gmail.com", :password => "secret").create(:title => "album")

      assert_equal "Wojciech Wnętrzak", album_show.author.name
    end
  end

  describe "#destroy" do
    it "gives true when success" do
      skip
      stub_request(:post, "https://www.google.com/accounts/ClientLogin").to_return(fixture("auth/success.txt"))
      stub_request(:delete, "https://picasaweb.google.com/data/entry/api/user/w.wnetrzak@gmail.com/albumid/123").to_return(:status => 200, :body => "")

      result = Picasa::API::Album.new(:user_id => "w.wnetrzak@gmail.com", :password => "secret").destroy("123")

      assert_equal true, result
    end
  end
end
