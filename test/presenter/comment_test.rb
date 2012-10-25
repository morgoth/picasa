# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::Presenter::Comment do
  describe "comment from comment list" do
    before do
      body = MultiJson.load(fixture("presenters/comment_list.json"))
      @comment = Picasa::Presenter::Comment.new(body["feed"]["entry"][0])
    end

    it "has author name" do
      assert_equal "Vinicius Teles", @comment.author.name
    end

    it "has author uri" do
      assert_equal "https://picasaweb.google.com/104662451283465127832", @comment.author.uri
    end

    it "has links" do
      assert_equal 2, @comment.links.size
    end

    it "has published" do
      assert_equal "2012-10-25T00:32:51+00:00", @comment.published.to_s
    end

    it "has updated" do
      assert_equal "2012-10-25T00:32:51+00:00", @comment.updated.to_s
    end

    it "has edited" do
      assert_equal "", @comment.edited.to_s
    end

    it "has etag" do
      assert_equal "W/\"D0YDQHkyfyp7ImA9WhNSEU8.\"", @comment.etag
    end

    it "has title" do
      assert_equal "Vinicius Teles", @comment.title
    end

    it "has content" do
      assert_equal "beautiful place", @comment.content
    end

    it "has id" do
      expected = "z13fufdr3znxifia004cgjbgjkmwyr5ot4g-1351125171797000"
      assert_equal expected, @comment.id
    end

    it "has photo_id" do
      assert_equal "5243694064984357442", @comment.photo_id
    end
  end
end
