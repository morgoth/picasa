# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::Presenter::Content do
  before do
    body = MultiXml.parse(fixture("presenters/album_show.xml"))
    @content = Picasa::Presenter::Content.new(body["feed"]["entry"][0]["content"])
  end

  it "has src" do
    expected = "https://lh4.googleusercontent.com/-O0AOpTAPGBQ/SMU_j4ADl9I/AAAAAAAAAFs/DRnmROPuRVU/Kashmir%252520range.jpg"
    assert_equal expected, @content.src
  end

  it "has type" do
    assert_equal "image/jpeg", @content.type
  end
end
