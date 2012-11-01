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
      VCR.use_cassette("auth-success") do
        client = Picasa::Client.new(:user_id => "w.wnetrzak@gmail.com", :password => Password)
        client.authenticate

        refute_nil client.authorization_header
      end
    end

    it "raises an ForbiddenError when authentication failed" do
      VCR.use_cassette("auth-failed") do
        client = Picasa::Client.new(:user_id => "w.wnetrzak@gmail.com", :password => "invalid")

        assert_raises(Picasa::ForbiddenError) do
          client.authenticate
        end
      end
    end
  end
end
