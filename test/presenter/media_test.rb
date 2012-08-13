# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::Presenter::Media do
  before do
    body = MultiXml.parse(fixture("presenters/album_show.xml"))
    @media = Picasa::Presenter::Media.new(body["feed"]["entry"][0]["group"])
  end

  it "has credit" do
    assert_equal "Wojciech Wnętrzak", @media.credit
  end

  it "has description" do
    assert_nil @media.description
  end

  it "has keywords" do
    assert_nil @media.keywords
  end

  it "has title" do
    assert_equal "Kashmir range.jpg", @media.title
  end

  it "has thumbnails" do
    assert_equal 3, @media.thumbnails.size
  end
end
