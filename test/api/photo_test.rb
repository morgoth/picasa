# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::API::Photo do
  describe "#create" do
    it "gives correct parsed body fragment" do
      skip
      stub_request(:post, "https://www.google.com/accounts/ClientLogin").to_return(fixture("auth/success.txt"))
      stub_request(:post, "https://picasaweb.google.com/data/feed/api/user/w.wnetrzak@gmail.com/albumid/123").to_return(fixture("photo/photo-created.txt"))

      photo = Picasa::API::Photo.new(:user_id => "w.wnetrzak@gmail.com", :password => "secret")
      photo_create = photo.create("123", :title => "test", :binary => "binary", :content_type => "image/png")

      assert_equal 27040, photo_create.size
    end

    it "raises ArgumentError when no title" do
      photo = Picasa::API::Photo.new(:user_id => "w.wnetrzak@gmail.com", :password => "secret")
      assert_raises Picasa::ArgumentError, /title/ do
        photo.create("123", :binary => "binary", :content_type => "image/png")
      end
    end

    it "raises ArgumentError when no binary" do
      photo = Picasa::API::Photo.new(:user_id => "w.wnetrzak@gmail.com", :password => "secret")
      assert_raises Picasa::ArgumentError, /binary/ do
        photo.create("123", :title => "test", :content_type => "image/png")
      end
    end

    it "raises ArgumentError when no content type" do
      photo = Picasa::API::Photo.new(:user_id => "w.wnetrzak@gmail.com", :password => "secret")
      assert_raises Picasa::ArgumentError, /content_type/ do
        photo.create("123", :title => "test", :binary => "binary")
      end
    end

    it "guesses required attributes from file path" do
      skip
      stub_request(:post, "https://www.google.com/accounts/ClientLogin").to_return(fixture("auth/success.txt"))
      stub_request(:post, "https://picasaweb.google.com/data/feed/api/user/w.wnetrzak@gmail.com/albumid/123").to_return(fixture("photo/photo-created.txt"))

      photo = Picasa::API::Photo.new(:user_id => "w.wnetrzak@gmail.com", :password => "secret")

      assert photo.create("123", :file_path => image_path("lena.jpg"))
    end
  end
end
