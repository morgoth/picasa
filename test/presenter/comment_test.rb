# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::Presenter::Comment do
  describe "comment from comment list" do
    before do
      body = MultiXml.parse(fixture("presenters/comment_list.xml"))
      @comment = Picasa::Presenter::Comment.new(body["feed"]["entry"])
    end

    it "has author name" do
      assert_equal "Wojciech Wnętrzak", @comment.author.name
    end

    it "has author uri" do
      assert_equal "https://picasaweb.google.com/106136347770555028022", @comment.author.uri
    end

    it "has links" do
      assert_equal 3, @comment.links.size
    end

    it "has published" do
      assert_equal "2012-09-30T09:02:57+00:00", @comment.published.to_s
    end

    it "has updated" do
      assert_equal "2012-09-30T09:02:57+00:00", @comment.updated.to_s
    end

    it "has edited" do
      assert_equal "2012-09-30T09:02:57+00:00", @comment.edited.to_s
    end

    it "has etag" do
      assert_equal "W/\"D0ADRn04fCp7ImA9WhJbGUQ.\"", @comment.etag
    end

    it "has title" do
      assert_equal "Wojciech Wnętrzak", @comment.title
    end

    it "has content" do
      assert_equal "testing comment", @comment.content
    end

    it "has id" do
      expected = "z13stn0rtrvkvpnbm04cgjbgjkmwyr5ot4g-1348995777334000"
      assert_equal expected, @comment.id
    end

    it "has photo_id" do
      assert_equal "5793892628357238194", @comment.photo_id
    end
  end
end
