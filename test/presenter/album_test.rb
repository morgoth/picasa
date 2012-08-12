# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::Presenter::Album do
  before do
    body = MultiXml.parse(fixture("presenters/album_list/album_list.xml"))
    @album = Picasa::Presenter::Album.new(body["feed"]["entry"][0])
  end

  it "has author name" do
    assert_equal "Wojciech Wnętrzak", @album.author.name
  end

  it "has author uri" do
    assert_equal "https://picasaweb.google.com/106136347770555028022", @album.author.uri
  end

  it "has links" do
    assert_equal 3, @album.links.size
  end

  it "has published" do
    assert_equal "2008-09-08T07:00:00.000Z", @album.published
  end

  it "has updated" do
    assert_equal "2011-07-28T18:26:00.345Z", @album.updated
  end

  it "has title" do
    assert_equal "test2", @album.title
  end

  it "has summary" do
    assert_nil @album.summary
  end

  it "has rights" do
    assert_equal "public", @album.rights
  end

  it "has id" do
    assert_equal "5243667126168669553", @album.id
  end

  it "has name" do
    assert_equal "Test2", @album.name
  end

  it "has location" do
    assert_nil @album.location
  end

  it "has access" do
    assert_equal "public", @album.access
  end

  it "has timestamp" do
    assert_equal "1220857200000", @album.timestamp
  end

  it "has numphotos" do
    assert_equal 3, @album.numphotos
  end

  it "has user" do
    assert_equal "106136347770555028022", @album.user
  end

  it "has nickname" do
    assert_equal "Wojciech Wnętrzak", @album.nickname
  end
end
