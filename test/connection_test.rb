require "helper"

describe Picasa::Connection do
  before do
    @connection = Picasa::Connection.new
  end

  describe "#path_with_query" do
    it "returns path when no params provided" do
      path = @connection.path_with_query("/data/feed/api")
      assert_equal "/data/feed/api", path
    end

    it "adds params to path" do
      path = @connection.path_with_query("/data/feed/api", {:q => "bomb"})
      assert_equal "/data/feed/api?q=bomb", path
    end
  end

  it "raises NotFound exception when 404 returned" do
    connection = Picasa::Connection.new
    uri        = URI.parse("/data/feed/api/user/some.user/albumid/non-existing")

    stub_request(:get, "https://picasaweb.google.com" + uri.path).to_return(fixture("exceptions/not_found.txt"))

    assert_raises Picasa::NotFoundError, "Invalid entity id: non-existing" do
      connection.get(:path => uri.path)
    end
  end

  it "raises PreconditionFailed exception when 412 returned" do
    connection = Picasa::Connection.new
    uri        = URI.parse("/data/feed/api/user/some.user/albumid/123")

    stub_request(:post, "https://www.google.com/accounts/ClientLogin").to_return(fixture("auth/success.txt"))
    stub_request(:delete, "https://picasaweb.google.com" + uri.path).to_return(fixture("exceptions/precondition_failed.txt"))

    assert_raises Picasa::PreconditionFailedError, "Mismatch: etags = [oldetag], version = [7]" do
      connection.delete(:path => uri.path, :headers => {"If-Match" => "oldetag"})
    end
  end
end
