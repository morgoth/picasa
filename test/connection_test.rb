require "helper"

describe Picasa::Connection do
  before do
    @connection = Picasa::Connection.new
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
