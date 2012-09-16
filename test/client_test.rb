require "helper"

describe Picasa::Client do
  it "raises ArgumentError when user_id is missing" do
    assert_raises(Picasa::ArgumentError, /user_id/) do
      Picasa::Client.new
    end
  end

  it "allows to assign custom authorization header" do
    client = Picasa::Client.new(:user_id => "john.doe", :authorization_header => "OAuth token")
    assert_equal "OAuth token", client.authorization_header
  end

  describe "#authenticate" do
    it "successfully authenticates" do
      client = Picasa::Client.new(:user_id => "john.doe@domain.com", :password => "secret")

      stub_request(:post, "https://www.google.com/accounts/ClientLogin").to_return(fixture("auth/success.txt"))

      client.authenticate
      refute_nil client.authorization_header
    end

    it "raises an ForbiddenError when authentication failed" do
      client = Picasa::Client.new(:user_id => "john.doe@domain.com", :password => "invalid")

      stub_request(:post, "https://www.google.com/accounts/ClientLogin").to_return(fixture("exceptions/forbidden.txt"))

      assert_raises(Picasa::ForbiddenError) do
        client.authenticate
      end
    end
  end
end
