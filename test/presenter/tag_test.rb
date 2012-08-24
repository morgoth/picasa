# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::Presenter::Tag do
  describe "album from album list" do
    before do
      body = MultiXml.parse(fixture("presenters/tag_list.xml"))
      @tag = Picasa::Presenter::Tag.new(body["feed"]["entry"][0])
    end

    it "has author name" do
      assert_equal "Wojciech Wnętrzak", @tag.author.name
    end

    it "has author uri" do
      assert_equal "https://picasaweb.google.com/106136347770555028022", @tag.author.uri
    end

    it "has links" do
      assert_equal 2, @tag.links.size
    end

    it "has updated" do
      assert_equal "2012-08-17T08:40:24+00:00", @tag.updated.to_s
    end

    it "has title" do
      assert_equal "nice", @tag.title
    end

    it "has summary" do
      assert_equal "nice", @tag.summary
    end

    it "has id" do
      expected = "https://picasaweb.google.com/data/entry/user/106136347770555028022/tag/nice"
      assert_equal expected, @tag.id
    end

    it "has weight" do
      assert_equal 2, @tag.weight
    end
  end
end
