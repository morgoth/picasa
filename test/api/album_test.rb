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

    it "has no photo entries" do
      assert_equal [], @album_list.entries.first.photos
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

    it "has subtitle" do
      assert_equal "Opis albumu", @album.subtitle
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
      assert_equal "1219906800", @album.timestamp
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

    describe "photo" do
      before do
        @photo = @album.entries.first
      end

      it "has id" do
        assert_equal "5239556203823850002", @photo.id
      end

      it "has links" do
        assert_equal 5, @photo.links.size
      end

      it "has media" do
        assert_equal 3, @photo.media.thumbnails.size
      end

      it "has content type" do
        assert_equal "image/jpeg", @photo.content.type
      end

      it "has etag" do
        assert_equal "\"YD4qeyI.\"", @photo.etag
      end

      it "has published" do
        assert_equal "2008-08-28T13:14:03+00:00", @photo.published.to_s
      end

      it "has updated" do
        assert_equal "2009-06-24T05:19:50+00:00", @photo.updated.to_s
      end

      it "has title" do
        assert_equal "lena2.jpg", @photo.title
      end

      it "has summary" do
        assert_equal "", @photo.summary
      end

      it "has album id" do
        assert_equal "5239555770355467953", @photo.album_id
      end

      it "has access" do
        assert_equal "public", @photo.access
      end

      it "has width" do
        assert_equal 1084, @photo.width
      end

      it "has height" do
        assert_equal 2318, @photo.height
      end

      it "has size" do
        assert_equal 570958, @photo.size
      end

      it "has checksum" do
        assert_equal "", @photo.checksum
      end

      it "has timestamp" do
        assert_equal "1219929243000", @photo.timestamp
      end

      it "has image version" do
        assert_equal 67, @photo.image_version
      end

      it "has commenting enabled" do
        assert_equal true, @photo.commenting_enabled
      end

      it "has comment count" do
        assert_equal 0, @photo.comment_count
      end

      it "has license" do
        assert_equal "All Rights Reserved", @photo.license
      end
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
        attributes = {:title => "gem-test", :summary => "created from test suite <&>", :access => "protected",
          :location => "Gilowice", :keywords => "test"}
        album = Picasa::API::Album.new(:user_id => "w.wnetrzak@gmail.com", :authorization_header => AuthHeader).create(attributes)

        assert_equal "gem-test", album.title
        assert_equal "created from test suite <&>", album.summary
        assert_equal "protected", album.access
        assert_equal "Gilowice", album.location
        assert_equal 10, album.timestamp.length
      end
    end
  end

  describe "#destroy" do
    it "gives true when success" do
      VCR.use_cassette("album-destroy") do
        result = Picasa::API::Album.new(:user_id => "w.wnetrzak@gmail.com", :authorization_header => AuthHeader).destroy("5805920347758933777")
        assert_equal true, result
      end
    end
  end
end
