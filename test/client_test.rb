require "helper"

describe Picasa::Client do
  it "has credentials" do
    client = Picasa::Client.new(:user_id => "john.doe")
    assert_equal({:user_id => "john.doe"}, client.credentials)
  end

  it "raises ArgumentError when user_id is missing" do
    assert_raises(Picasa::ArgumentError, /user_id/) do
      Picasa::Client.new
    end
  end
end
