# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::Presenter::Media do
  before do
    body = MultiJson.load(fixture("presenters/album_show.json"))
    @media = Picasa::Presenter::Media.new(body["feed"]["entry"][0]["media$group"])
  end

  it "has credit" do
    assert_equal "Wojciech Wnętrzak", @media.credit
  end

  it "has description" do
    assert_equal "", @media.description
  end

  it "has keywords" do
    assert_nil @media.keywords
  end

  it "has title" do
    assert_equal "lena2.jpg", @media.title
  end

  it "has thumbnails" do
    assert_equal 3, @media.thumbnails.size
  end
end
