# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::Presenter::Photo do
  before do
    body = MultiJson.load(fixture("presenters/album_show.json"))
    @photo = Picasa::Presenter::Photo.new(body["feed"]["entry"][0])
  end

  it "has links" do
    assert_equal 5, @photo.links.size
  end

  it "has content src" do
    expected = "https://lh3.googleusercontent.com/-nyHpFHvhL5o/SLakm2WdYhI/AAAAAAAAAEM/DuJDO5CflfY/lena2.jpg"
    assert_equal expected, @photo.content.src
  end

  it "has media credit" do
    assert_equal "Wojciech Wnętrzak", @photo.media.credit
  end

  it "has etag" do
    assert_equal "\"YD4qeyI.\"", @photo.etag
  end

  it "has id" do
    assert_equal "5239556203823850002", @photo.id
  end

  it "has published" do
    assert_equal "2008-08-28T13:14:03+00:00", @photo.published.to_s
  end

  it "has updated" do
    assert_equal "2009-06-24T05:19:50+00:00", @photo.updated.to_s
  end

  it "has title" do
    assert_equal "lena2.jpg", @photo.title
  end

  it "has summary" do
    assert_equal "", @photo.summary
  end

  it "has album_id" do
    assert_equal "5239555770355467953", @photo.album_id
  end

  it "has access" do
    assert_equal "public", @photo.access
  end

  it "has width" do
    assert_equal 1084, @photo.width
  end

  it "has height" do
    assert_equal 2318, @photo.height
  end

  it "has size" do
    assert_equal 570958, @photo.size
  end

  it "has checksum" do
    assert_equal '',  @photo.checksum
  end

  it "has timestamp" do
    assert_equal "1219929243000", @photo.timestamp
  end

  it "has image_version" do
    assert_equal 67, @photo.image_version
  end

  it "has commenting_enabled" do
    assert_equal true, @photo.commenting_enabled
  end

  it "has comment_count" do
    assert_equal 0, @photo.comment_count
  end

  it "has license" do
    assert_equal "All Rights Reserved", @photo.license
  end
end
