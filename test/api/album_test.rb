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

  describe "#create" do
    it "gives correct parsed body fragment" do
      stub_request(:post, "https://www.google.com/accounts/ClientLogin").to_return(fixture("auth/success.txt"))
      stub_request(:post, "https://picasaweb.google.com/data/feed/api/user/w.wnetrzak@gmail.com").to_return(fixture("album/album-create.txt"))

      album_show = Picasa::API::Album.new(:user_id => "w.wnetrzak@gmail.com", :password => "secret").create(:title => "album")

      assert_equal "Wojciech Wnętrzak", album_show.author.name
    end
  end

  describe "#destroy" do
    it "gives true when success" do
      stub_request(:post, "https://www.google.com/accounts/ClientLogin").to_return(fixture("auth/success.txt"))
      stub_request(:delete, "https://picasaweb.google.com/data/entry/api/user/w.wnetrzak@gmail.com/albumid/123").to_return(:status => 200, :body => "")

      result = Picasa::API::Album.new(:user_id => "w.wnetrzak@gmail.com", :password => "secret").destroy("123")

      assert_equal true, result
    end
  end
end
