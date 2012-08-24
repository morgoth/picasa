# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::Presenter::TagList do
  before do
    body = MultiXml.parse(fixture("presenters/tag_list.xml"))
    @tag_list = Picasa::Presenter::TagList.new(body["feed"])
  end

  it "has author name" do
    assert_equal "Wojciech Wnętrzak", @tag_list.author.name
  end

  it "has author uri" do
    assert_equal "https://picasaweb.google.com/106136347770555028022", @tag_list.author.uri
  end

  it "has links" do
    assert_equal 4, @tag_list.links.size
  end

  it "has title" do
    assert_equal "106136347770555028022", @tag_list.title
  end

  it "has updated" do
    assert_equal "2012-08-17T08:40:24+00:00", @tag_list.updated.to_s
  end

  it "has icon" do
    expected = "https://lh3.googleusercontent.com/-6ezHc54U8x0/AAAAAAAAAAI/AAAAAAAAAAA/PBuxm7Ehn6E/s64-c/106136347770555028022.jpg"
    assert_equal expected, @tag_list.icon
  end

  it "has generator" do
    assert_equal "Picasaweb", @tag_list.generator
  end

  it "has total_results" do
    assert_equal 2, @tag_list.total_results
  end

  it "has start_index" do
    assert_equal 1, @tag_list.start_index
  end

  it "has items_per_page" do
    assert_equal 500, @tag_list.items_per_page
  end

  it "has user" do
    assert_equal "106136347770555028022", @tag_list.user
  end

  it "has nickname" do
    assert_equal "Wojciech Wnętrzak", @tag_list.nickname
  end

  it "has thumbnail" do
    expected = "https://lh3.googleusercontent.com/-6ezHc54U8x0/AAAAAAAAAAI/AAAAAAAAAAA/PBuxm7Ehn6E/s64-c/106136347770555028022.jpg"
    assert_equal expected, @tag_list.thumbnail
  end

  it "has entries" do
    assert_equal 2, @tag_list.entries.size
  end
end
