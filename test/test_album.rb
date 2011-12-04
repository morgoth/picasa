# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::Album do
  describe "#list" do
    before do
      response = fixture_file("album-list.txt")
      FakeWeb.register_uri(:get, "https://picasaweb.google.com/data/feed/api/user/w.wnetrzak", :response => response)
      @album = Picasa::Album.new("w.wnetrzak")
    end

    it "should have album entries" do
      assert_equal 2, @album.list["feed"]["entry"].size
    end

    it "should have album attributes" do
      album_1 = @album.list["feed"]["entry"][0]
      assert_equal "5243667126168669553", album_1["id"][1]
      assert_equal "test2", album_1["title"]
      assert_equal "3", album_1["numphotos"]
    end

    it "should have slideshow" do
      assert_equal "application/x-shockwave-flash", @album.list["feed"]["link"][2]["type"]
      refute_nil @album.list["feed"]["link"][2]["href"]
    end

    it "should have author" do
      assert_equal "Wojciech Wnętrzak", @album.list["feed"]["author"]["name"]
    end
  end

  describe "#show" do
    before do
      response = fixture_file("album-show.txt")
      FakeWeb.register_uri(:get, "https://picasaweb.google.com/data/feed/api/user/w.wnetrzak/albumid/5243667126168669553", :response => response)
      @album = Picasa::Album.new("w.wnetrzak")
    end

    it "should have slideshow" do
      assert_equal "application/x-shockwave-flash", @album.show("5243667126168669553")["feed"]["link"][2]["type"]
      refute_nil @album.list["feed"]["link"][2]["href"]
    end

    it "should have photo entries" do
      assert_equal 3, @album.show("5243667126168669553")["feed"]["entry"].size
    end

    it "should have author" do
      assert_equal "Wojciech Wnętrzak", @album.show("5243667126168669553")["feed"]["author"]["name"]
    end

    it "should have alias to photos" do
      assert_equal @album.show("5243667126168669553"), @album.photos("5243667126168669553")
    end

    it "should have thumbnails" do
      thumbnails = @album.show("5243667126168669553")["feed"]["entry"][0]["group"]["thumbnail"]
      assert_equal 3, thumbnails.size
      refute_nil thumbnails[0]["url"]
      assert_equal "47", thumbnails[0]["height"]
      assert_equal "72", thumbnails[0]["width"]
    end
  end
end
