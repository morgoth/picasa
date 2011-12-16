# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::Album do
  describe "#list" do
    before do
      @tag = Picasa::Tag.new("w.wnetrzak")
    end

    it "should raise argument error when photo_id passed but without album_id" do
      assert_raises(::ArgumentError) do
        @tag.list(:photo_id => "123")
      end
    end

    it "should have tag entries" do
      response = fixture_file("tag/tag-list.txt")
      FakeWeb.register_uri(:get, "https://picasaweb.google.com/data/feed/api/user/w.wnetrzak?kind=tag", :response => response)
      assert_equal 2, @tag.list["entry"].size
    end

    it "should have tag entries on album" do
      response = fixture_file("tag/tag-list-album.txt")
      FakeWeb.register_uri(:get, "https://picasaweb.google.com/data/feed/api/user/w.wnetrzak/albumid/5243667126168669553?kind=tag", :response => response)
      assert_equal 2, @tag.list(:album_id => "5243667126168669553")["entry"].size
    end

    it "should have tag entries on photo" do
      response = fixture_file("tag/tag-list-photo.txt")
      FakeWeb.register_uri(:get, "https://picasaweb.google.com/data/feed/api/user/w.wnetrzak/albumid/5243667126168669553/photoid/5634470303146876834?kind=tag", :response => response)
      refute_nil @tag.list(:album_id => "5243667126168669553", :photo_id => "5634470303146876834")["entry"]
    end
  end
end
