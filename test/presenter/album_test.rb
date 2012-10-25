# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::Presenter::Album do
  describe "album from album list" do
    before do
      body = MultiJson.load(fixture("presenters/album_list.json"))
      @album = Picasa::Presenter::Album.new(body["feed"]["entry"][0])
    end

    it "has author name" do
      assert_equal "Wojciech Wnętrzak", @album.author.name
    end

    it "has author uri" do
      assert_equal "https://picasaweb.google.com/106136347770555028022", @album.author.uri
    end

    it "has links" do
      assert_equal 3, @album.links.size
    end

    it "has etag" do
      assert_equal "\"WSp7ImA9\"", @album.etag
    end

    it "has media credit" do
      assert_equal "Wojciech Wnętrzak", @album.media.credit
    end

    it "has media description" do
      assert_equal "Opis albumu", @album.media.description
    end

    it "has media title" do
      assert_equal "test", @album.media.title
    end

    it "has media thumbnail url" do
      assert_equal "https://lh6.googleusercontent.com/-ZqXRf3HicvI/SLakNnjixrE/AAAAAAAAAkc/3EAZ0eF3-CQ/s160-c/Test.jpg", @album.media.thumbnails[0].url
    end

    it "has published" do
      assert_equal "2008-08-28T07:00:00+00:00", @album.published.to_s
    end

    it "has updated" do
      assert_equal "2011-12-12T17:09:21+00:00", @album.updated.to_s
    end

    it "has title" do
      assert_equal "test", @album.title
    end

    it "has summary" do
      assert_equal "Opis albumu", @album.summary
    end

    it "has rights" do
      assert_equal "public", @album.rights
    end

    it "has id" do
      assert_equal "5239555770355467953", @album.id
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

    it "has empty photo entries" do
      assert_empty @album.entries
    end
  end

  describe "album from album show" do
    before do
      body = MultiJson.load(fixture("presenters/album_show.json"))
      @album = Picasa::Presenter::Album.new(body["feed"])
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
      assert_equal "2012-09-30T08:49:33+00:00", @album.updated.to_s
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
      assert_equal "W/\"Dk4DQn49eip7ImA9WhJbGUQ.\"", @album.etag
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

  describe "album from show with single photo" do
    before do
      body = MultiJson.load(fixture("presenters/album_show_with_one_photo.json"))
      @album = Picasa::Presenter::Album.new(body["feed"])
    end

    it "has single photo entry in array" do
      assert_kind_of Array, @album.entries
    end
  end
end
