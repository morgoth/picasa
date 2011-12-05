require "helper"

describe Picasa::Client do
  before do
    @client = Picasa::Client.new("joe.doe")
  end

  describe "#inline_params" do
    it "should convert params to inline style" do
      params = @client.inline_params({:alt => "json", :kind => "photo"})
      assert_equal "alt=json&kind=photo", params
    end

    it "should change param keys underscore to dash" do
      params = @client.inline_params({:max_results => 10})
      assert_equal "max-results=10", params
    end
  end

  describe "#path_with_params" do
    it "should return path when no params provided" do
      path = @client.path_with_params("/data/feed/api")
      assert_equal "/data/feed/api", path
    end

    it "should add params to path" do
      path = @client.path_with_params("/data/feed/api", {:q => "bomb"})
      assert_equal "/data/feed/api?q=bomb", path
    end
  end
end
