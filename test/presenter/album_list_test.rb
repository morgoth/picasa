# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::Presenter::AlbumList do
  before do
    body = MultiXml.parse(fixture("presenters/album_list/album_list.xml"))
    @album_list = Picasa::Presenter::AlbumList.new(body)
  end

  it "has albums" do
    assert_equal 2, @album_list.albums.size
  end
end
