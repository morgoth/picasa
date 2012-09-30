# -*- encoding: utf-8 -*-
require "helper"

describe Picasa::Presenter::CommentList do
  before do
    body = MultiXml.parse(fixture("presenters/comment_list.xml"))
    @comment_list = Picasa::Presenter::CommentList.new(body["feed"])
  end

  it "has author name" do
    assert_equal "Wojciech Wnętrzak", @comment_list.author.name
  end

  it "has author uri" do
    assert_equal "https://picasaweb.google.com/106136347770555028022", @comment_list.author.uri
  end

  it "has links" do
    assert_equal 4, @comment_list.links.size
  end

  it "has title" do
    assert_equal "106136347770555028022", @comment_list.title
  end

  it "has updated" do
    assert_equal "2012-09-30T09:02:57+00:00", @comment_list.updated.to_s
  end

  it "has icon" do
    expected = "https://lh3.googleusercontent.com/-6ezHc54U8x0/AAAAAAAAAAI/AAAAAAAAAAA/PBuxm7Ehn6E/s64-c/106136347770555028022.jpg"
    assert_equal expected, @comment_list.icon
  end

  it "has generator" do
    assert_equal "Picasaweb", @comment_list.generator
  end

  it "has total_results" do
    assert_equal 1, @comment_list.total_results
  end

  it "has start_index" do
    assert_equal 1, @comment_list.start_index
  end

  it "has items_per_page" do
    assert_equal 100, @comment_list.items_per_page
  end

  it "has user" do
    assert_equal "106136347770555028022", @comment_list.user
  end

  it "has nickname" do
    assert_equal "Wojciech Wnętrzak", @comment_list.nickname
  end

  it "has thumbnail" do
    expected = "https://lh3.googleusercontent.com/-6ezHc54U8x0/AAAAAAAAAAI/AAAAAAAAAAA/PBuxm7Ehn6E/s64-c/106136347770555028022.jpg"
    assert_equal expected, @comment_list.thumbnail
  end

  it "has entries" do
    assert_equal 1, @comment_list.entries.size
  end
end
