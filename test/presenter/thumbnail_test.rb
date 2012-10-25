# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::Presenter::Thumbnail do
  describe "album list" do
    before do
      body = MultiJson.load(fixture("presenters/album_list.json"))
      @thumbnail = Picasa::Presenter::Thumbnail.new(body["feed"]["entry"][0]["media$group"]["media$thumbnail"][0])
    end

    it "has url" do
      expected = "https://lh6.googleusercontent.com/-ZqXRf3HicvI/SLakNnjixrE/AAAAAAAAAkc/3EAZ0eF3-CQ/s160-c/Test.jpg"
      assert_equal expected, @thumbnail.url
    end

    it "has height" do
      assert_equal 160, @thumbnail.height
    end

    it "has width" do
      assert_equal 160, @thumbnail.width
    end
  end
end
