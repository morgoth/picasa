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

  describe "Authentication" do
    before do
      @client           = Picasa::Client.new("john.doe@domain.com")
      @client.password  = "secret"
      @uri              = URI.parse("/data/feed/api/user/#{@client.user_id}")
    end

    describe "Succesfull" do
      before do
        response = fixture_file("auth/success.txt")
        FakeWeb.register_uri(:post, "https://www.google.com/accounts/ClientLogin", :response => response)

        response = fixture_file("album/album-list.txt")
        FakeWeb.register_uri(:get, "https://picasaweb.google.com/data/feed/api/user/john.doe@domain.com", :response => response)
      end

      it "Invokes authentication if password is set" do
        @client.expects(:authenticate).returns(:result)
        refute_nil @client.get(@uri.path)
      end

      it "Only authenticates when a password is given" do
        @client.password = nil
        @client.expects(:authenticate).never
        @client.get(@uri.path)
      end
    end

    describe "Failures" do
      before do
        response = fixture_file("auth/failure.txt")
        FakeWeb.register_uri(:post, "https://www.google.com/accounts/ClientLogin", :response => response)
      end

      it "Raises an ArgumentError when validation failed" do
        assert_raises(::ArgumentError) do
          @client.get(@uri.path)
        end
      end

      it "Raises an error when an invalid Email is given" do
        @client.user_id = "john.doe"

        assert_raises(::ArgumentError) do
          @client.get(@uri.path)
        end
      end
    end
  end
end
