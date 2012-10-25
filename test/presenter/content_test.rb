# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::Presenter::Content do
  before do
    body = MultiJson.load(fixture("presenters/album_show.json"))
    @content = Picasa::Presenter::Content.new(body["feed"]["entry"][0]["content"])
  end

  it "has src" do
    expected = "https://lh3.googleusercontent.com/-nyHpFHvhL5o/SLakm2WdYhI/AAAAAAAAAEM/DuJDO5CflfY/lena2.jpg"
    assert_equal expected, @content.src
  end

  it "has type" do
    assert_equal "image/jpeg", @content.type
  end
end
