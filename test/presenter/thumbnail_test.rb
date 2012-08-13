# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::Presenter::Thumbnail do
  describe "album list" do
    before do
      body = MultiXml.parse(fixture("presenters/album_list.xml"))
      @thumbnail = Picasa::Presenter::Thumbnail.new(body["feed"]["entry"][0]["group"]["thumbnail"])
    end

    it "has url" do
      expected = "https://lh6.googleusercontent.com/-u_2FJXbbliU/SMU_eBetTXE/AAAAAAAAAkU/3XThNVnAM-4/s160-c/Test2.jpg"
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
