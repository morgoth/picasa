# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::Presenter::Link do
  before do
    body = MultiXml.parse(fixture("presenters/album_list/album_list.xml"))
    @link = Picasa::Presenter::Link.new(body["feed"]["link"][0])
  end

  it "has rel" do
    assert_equal "http://schemas.google.com/g/2005#feed", @link.rel
  end

  it "has type" do
    assert_equal "application/atom+xml", @link.type
  end

  it "has href" do
    assert_equal "https://picasaweb.google.com/data/feed/api/user/106136347770555028022", @link.href
  end
end
