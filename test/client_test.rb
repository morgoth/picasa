require "helper"

describe Picasa::Client do
  it "raises ArgumentError when user_id is missing" do
    assert_raises(Picasa::ArgumentError, /user_id/) do
      Picasa::Client.new
    end
  end

  it "raises ArgumentError when providing password" do
    assert_raises(Picasa::ArgumentError) do
      client = Picasa::Client.new(:user_id => "john.doe", :password => "unknown")
    end
  end

  it "allows to set access_token on instance" do
    client = Picasa::Client.new(:user_id => "john.doe")
    client.access_token = "some-access-token"

    assert_equal "some-access-token", client.access_token
  end
end
