# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::API::Photo do
  describe "#create" do
    it "creates photo" do
      VCR.use_cassette("photo-create") do
        attributes = {:file_path => image_path("lena.jpg"), :title => "Lena"}

        photo = Picasa::API::Photo.new(:user_id => "w.wnetrzak@gmail.com", :authorization_header => AuthHeader).create("5793892606777564353", attributes)

        assert_equal "Lena", photo.title
      end
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
  end

  describe "#destroy" do
    it "destroys photo" do
      VCR.use_cassette("photo-destroy") do
        album_id = "5793892606777564353"
        photo_id = "5806295577614146146"
        result = Picasa::API::Photo.new(:user_id => "w.wnetrzak@gmail.com", :authorization_header => AuthHeader).destroy(album_id, photo_id)

        assert_equal true, result
      end
    end
  end

  describe "exceptions" do
    it "raises PreconditionFailedError exception when photo not fresh" do
      VCR.use_cassette("photo-412") do
        album_id = "5793892606777564353"
        photo_id = "5806295577614146146"

        assert_raises Picasa::PreconditionFailedError, "Mismatch: etags = [Not-Fresh], version = [8]" do
          Picasa::API::Photo.new(:user_id => "w.wnetrzak@gmail.com", :authorization_header => AuthHeader).destroy(album_id, photo_id, :etag => "Not-Fresh")
        end
      end
    end
  end
end
