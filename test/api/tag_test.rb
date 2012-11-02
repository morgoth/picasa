# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::API::Tag do
  describe "#list" do
    before do
      VCR.use_cassette("tag-list") do
        @tag_list = Picasa::API::Tag.new(:user_id => "w.wnetrzak").list
      end
    end

    it "throws ArgumentError when photo_id provided without album_id" do
      tag = Picasa::API::Tag.new(:user_id => "w.wnetrzak")

      assert_raises Picasa::ArgumentError, /album_id/ do
        tag.list(:photo_id => "12343")
      end
    end

    it "has author name" do
      assert_equal "Wojciech Wnętrzak", @tag_list.author.name
    end

    it "has author uri" do
      assert_equal "https://picasaweb.google.com/106136347770555028022", @tag_list.author.uri
    end

    it "has links" do
      assert_equal 4, @tag_list.links.size
    end

    it "has title" do
      assert_equal "106136347770555028022", @tag_list.title
    end

    it "has updated" do
      assert_equal "2012-11-01T04:47:09+00:00", @tag_list.updated.to_s
    end

    it "has icon" do
      expected = "https://lh3.googleusercontent.com/-6ezHc54U8x0/AAAAAAAAAAI/AAAAAAAAAAA/PBuxm7Ehn6E/s64-c/106136347770555028022.jpg"
      assert_equal expected, @tag_list.icon
    end

    it "has generator" do
      assert_equal "Picasaweb", @tag_list.generator
    end

    it "has total_results" do
      assert_equal 1, @tag_list.total_results
    end

    it "has start_index" do
      assert_equal 1, @tag_list.start_index
    end

    it "has items_per_page" do
      assert_equal 500, @tag_list.items_per_page
    end

    it "has user" do
      assert_equal "106136347770555028022", @tag_list.user
    end

    it "has nickname" do
      assert_equal "Wojciech Wnętrzak", @tag_list.nickname
    end

    it "has thumbnail" do
      expected = "https://lh3.googleusercontent.com/-6ezHc54U8x0/AAAAAAAAAAI/AAAAAAAAAAA/PBuxm7Ehn6E/s64-c/106136347770555028022.jpg"
      assert_equal expected, @tag_list.thumbnail
    end

    it "has entries" do
      assert_equal 1, @tag_list.entries.size
    end

    it "has tag title" do
      assert_equal "nature", @tag_list.entries.first.title
    end
  end

  describe "#create" do
    it "creates tag" do
      VCR.use_cassette("tag-create") do
        attributes = {:album_id => "5793892606777564353", :photo_id => "5806295577614146146", :title => "beauty"}

        tag = Picasa::API::Tag.new(:user_id => "w.wnetrzak@gmail.com", :authorization_header => AuthHeader).create(attributes)

        assert_equal "beauty", tag.title
      end
    end

    it "raises ArgumentError when no album_id" do
      tag = Picasa::API::Tag.new(:user_id => "w.wnetrzak@gmail.com", :password => "secret")
      assert_raises Picasa::ArgumentError, /album_id/ do
        tag.create(:photo_id => "455", :title => "title")
      end
    end

    it "raises ArgumentError when no photo_id" do
      tag = Picasa::API::Tag.new(:user_id => "w.wnetrzak@gmail.com", :password => "secret")
      assert_raises Picasa::ArgumentError, /photo_id/ do
        tag.create(:album_id => "123", :title => "title")
      end
    end

    it "raises ArgumentError when no title" do
      tag = Picasa::API::Tag.new(:user_id => "w.wnetrzak@gmail.com", :password => "secret")
      assert_raises Picasa::ArgumentError, /title/ do
        tag.create(:album_id => "123", :photo_id => "455")
      end
    end
  end

  describe "#destroy" do
    it "destroys tag" do
      VCR.use_cassette("tag-destroy") do
        attributes = {:album_id => "5793892606777564353", :photo_id => "5806295577614146146"}

        result = Picasa::API::Tag.new(:user_id => "w.wnetrzak@gmail.com", :authorization_header => AuthHeader).destroy("beauty", attributes)

        assert_equal true, result
      end
    end

    it "raises ArgumentError when no photo_id" do
      tag = Picasa::API::Tag.new(:user_id => "w.wnetrzak@gmail.com", :password => "secret")
      assert_raises Picasa::ArgumentError, /photo_id/ do
        tag.destroy("wtf", :album_id => "123")
      end
    end

    it "raises ArgumentError when no album_id" do
      tag = Picasa::API::Tag.new(:user_id => "w.wnetrzak@gmail.com", :password => "secret")
      assert_raises Picasa::ArgumentError, /album_id/ do
        tag.destroy("wtf", :photo_id => "455")
      end
    end
  end
end
