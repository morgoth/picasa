# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::API::Album do
  describe "#list" do
    it "gives correct parsed body fragment" do
      stub_request(:get, "https://picasaweb.google.com/data/feed/api/user/w.wnetrzak").to_return(fixture("album/album-list.txt"))

      album_list = Picasa::API::Album.new(:user_id => "w.wnetrzak").list

      assert_equal 2, album_list.total_results
    end
  end

  describe "#show" do
    it "gives correct parsed body fragment" do
      stub_request(:get, "https://picasaweb.google.com/data/feed/api/user/w.wnetrzak/albumid/5243667126168669553").to_return(fixture("album/album-show.txt"))

      album_show = Picasa::API::Album.new(:user_id => "w.wnetrzak").show("5243667126168669553")

      assert_equal "Wojciech Wnętrzak", album_show.author.name
    end
  end
end
