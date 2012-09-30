# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::API::Comment do
  describe "#list" do
    it "throws ArgumentError when photo_id provided without album_id" do
      comment = Picasa::API::Comment.new(:user_id => "w.wnetrzak")

      assert_raises Picasa::ArgumentError, /album_id/ do
        comment.list(:photo_id => "12343")
      end
    end

    it "gives correct parsed body fragment" do
      stub_request(:get, "https://picasaweb.google.com/data/feed/api/user/w.wnetrzak?kind=comment").to_return(fixture("comment/comment-list.txt"))

      comment_list = Picasa::API::Comment.new(:user_id => "w.wnetrzak").list

      assert_equal 1, comment_list.entries.size
    end
  end

  describe "#create" do
    it "raises ArgumentError when no album_id" do
      comment = Picasa::API::Comment.new(:user_id => "w.wnetrzak@gmail.com", :password => "secret")
      assert_raises Picasa::ArgumentError, /album_id/ do
        comment.create(:photo_id => "455", :content => "content")
      end
    end

    it "raises ArgumentError when no photo_id" do
      comment = Picasa::API::Comment.new(:user_id => "w.wnetrzak@gmail.com", :password => "secret")
      assert_raises Picasa::ArgumentError, /photo_id/ do
        comment.create(:album_id => "123", :content => "content")
      end
    end

    it "raises ArgumentError when no content" do
      comment = Picasa::API::Comment.new(:user_id => "w.wnetrzak@gmail.com", :password => "secret")
      assert_raises Picasa::ArgumentError, /content/ do
        comment.create(:album_id => "123", :photo_id => "455")
      end
    end
  end

  describe "#destroy" do
    it "raises ArgumentError when no photo_id" do
      comment = Picasa::API::Comment.new(:user_id => "w.wnetrzak@gmail.com", :password => "secret")
      assert_raises Picasa::ArgumentError, /photo_id/ do
        comment.destroy("wtf", :album_id => "123")
      end
    end

    it "raises ArgumentError when no album_id" do
      comment = Picasa::API::Comment.new(:user_id => "w.wnetrzak@gmail.com", :password => "secret")
      assert_raises Picasa::ArgumentError, /album_id/ do
        comment.destroy("wtf", :photo_id => "455")
      end
    end

    it "gives true when success" do
      stub_request(:post, "https://www.google.com/accounts/ClientLogin").to_return(fixture("auth/success.txt"))
      stub_request(:delete, "https://picasaweb.google.com/data/entry/api/user/w.wnetrzak@gmail.com/albumid/123/photoid/456/commentid/987").to_return(:status => 200, :body => "")

      result = Picasa::API::Comment.new(:user_id => "w.wnetrzak@gmail.com", :password => "secret").destroy("987", :album_id => "123", :photo_id => "456")

      assert_equal true, result
    end
  end
end
