require "helper"

describe Picasa::Connection do
  before do
    @connection = Picasa::Connection.new(:user_id => "joe.doe")
  end

  describe "#inline_params" do
    it "converts params to inline style" do
      params = @connection.inline_params({:alt => "json", :kind => "photo"})
      # make ruby 1.8 tests pass
      assert_equal "alt=json", params.split("&").sort[0]
      assert_equal "kind=photo", params.split("&").sort[1]
    end

    it "changes param keys underscore to dash" do
      params = @connection.inline_params({:max_results => 10})
      assert_equal "max-results=10", params
    end
  end

  describe "#path_with_params" do
    it "returns path when no params provided" do
      path = @connection.path_with_params("/data/feed/api")
      assert_equal "/data/feed/api", path
    end

    it "adds params to path" do
      path = @connection.path_with_params("/data/feed/api", {:q => "bomb"})
      assert_equal "/data/feed/api?q=bomb", path
    end
  end

  # describe "Authentication" do
  #   before do
  #     @connection = Picasa::Connection.new(:user_id => "john.doe@domain.com", :passsword => "secret")
  #     @uri        = URI.parse("/data/feed/api/user/#{@connection.user_id}")
  #   end

  #   describe "Succesfull" do
  #     before do
  #       response = fixture("auth/success.txt")
  #       FakeWeb.register_uri(:post, "https://www.google.com/accounts/ClientLogin", :response => response)

  #       response = fixture("album/album-list.txt")
  #       FakeWeb.register_uri(:get, "https://picasaweb.google.com/data/feed/api/user/john.doe@domain.com", :response => response)
  #     end

  #     it "Invokes authentication if password is set" do
  #       @connection.expects(:authenticate).returns(:result)
  #       refute_nil @connection.get(@uri.path)
  #     end
  #   end

  #   describe "Failures" do
  #     before do
  #       response = fixture("auth/failure.txt")
  #       FakeWeb.register_uri(:post, "https://www.google.com/accounts/ClientLogin", :response => response)
  #     end

  #     it "Raises an ArgumentError when validation failed" do
  #       assert_raises(::ArgumentError) do
  #         @connection.get(@uri.path)
  #       end
  #     end

  #     it "Raises an error when an invalid Email is given" do
  #       connection = Picasa::Connection.new(:user_id => "john.doe", :passsword => "secret")
  #       uri        = URI.parse("/data/feed/api/user/#{connection.user_id}")

  #       assert_raises(::ArgumentError) do
  #         connection.get(uri.path)
  #       end
  #     end
  #   end
  # end
end
