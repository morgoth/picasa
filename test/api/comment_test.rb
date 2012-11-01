# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::API::Comment do
  describe "#list" do
    before do
      VCR.use_cassette("comment-list") do
        @comment_list = Picasa::API::Comment.new(:user_id => "w.wnetrzak").list(:album_id => "5239555770355467953")
      end
    end

    it "throws ArgumentError when photo_id provided without album_id" do
      comment = Picasa::API::Comment.new(:user_id => "w.wnetrzak")

      assert_raises Picasa::ArgumentError, /album_id/ do
        comment.list(:photo_id => "12343")
      end
    end

    it "has author name" do
      assert_equal "Wojciech Wnętrzak", @comment_list.author.name
    end

    it "has author uri" do
      assert_equal "https://picasaweb.google.com/106136347770555028022", @comment_list.author.uri
    end

    it "has links" do
      assert_equal 5, @comment_list.links.size
    end

    it "has title" do
      assert_equal "test", @comment_list.title
    end

    it "has updated" do
      assert_equal "2012-10-25T00:32:51+00:00", @comment_list.updated.to_s
    end

    it "has icon" do
      expected = "https://lh6.googleusercontent.com/-ZqXRf3HicvI/SLakNnjixrE/AAAAAAAAAkc/3EAZ0eF3-CQ/s160-c/Test.jpg"
      assert_equal expected, @comment_list.icon
    end

    it "has generator" do
      assert_equal "Picasaweb", @comment_list.generator
    end

    it "has total_results" do
      assert_equal 1, @comment_list.total_results
    end

    it "has start_index" do
      assert_equal 1, @comment_list.start_index
    end

    it "has items_per_page" do
      assert_equal 500, @comment_list.items_per_page
    end

    it "has user" do
      assert_equal "106136347770555028022", @comment_list.user
    end

    it "has nickname" do
      assert_equal "Wojciech Wnętrzak", @comment_list.nickname
    end

    it "has entries" do
      assert_equal 1, @comment_list.entries.size
    end

    it "has content" do
      assert_equal "beautiful place", @comment_list.entries.first.content
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
      skip
      stub_request(:post, "https://www.google.com/accounts/ClientLogin").to_return(fixture("auth/success.txt"))
      stub_request(:delete, "https://picasaweb.google.com/data/entry/api/user/w.wnetrzak@gmail.com/albumid/123/photoid/456/commentid/987").to_return(:status => 200, :body => "")

      result = Picasa::API::Comment.new(:user_id => "w.wnetrzak@gmail.com", :password => "secret").destroy("987", :album_id => "123", :photo_id => "456")

      assert_equal true, result
    end
  end
end
