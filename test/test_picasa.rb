require "helper"

describe Picasa do
  it "should allow to set custom settings" do
    Picasa.configure do |config|
      config.user_id = "john.doe"
    end

    assert_equal "john.doe", Picasa.user_id
  end
end
